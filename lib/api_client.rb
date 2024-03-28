# frozen_string_literal: true

require 'httparty'

class ApiClient
  include HTTParty

  # get_data is called from two places, home_controller and admin_reload_controller

  def self.get_data(endpoint, options = {})
    # Getting api for listed OSU courses
    response = HTTParty.get(endpoint, query: options)
    responseParsed = JSON.parse(response.body)

    # coursesArray is an array of every course
    coursesArray = responseParsed['data']['courses']

    # Going through every course to pull information
    coursesArray.each do |courseTemp|
      # If a course doesn't exist that has the same name then add a new row
      if !Course.exists?(name: courseTemp['course']['title'])

        # Temp variable for course data, just used for readability
        courseTempData = courseTemp['course']

        # Putting the course inside of the DB
        @p1Course = Course.create name: courseTempData['title'],
                                  catalog_number: courseTempData['catalogNumber'].to_f, course_description: courseTempData['description'], credit_hours: courseTempData['minUnits'], academic_career: courseTempData['academicCareer'], class_level: courseTempData['catalogLevel']
        @tempCourseID = @p1Course.id

      else

        # If the current course being looked at has the same name as a DB course then fill temp variables
        @tempCourseID = Course.find_by(name: courseTemp['course']['title']).id

      end

      # courseSections is an array of singular sections
      courseSections = courseTemp['sections']

      # Going through all different sections for tempCourse
      courseSections.each do |singleSection|
        # Creating section table and getting it ready to save attributes
        p1Section = Section.create course_id: @tempCourseID
        section = Section.find_by(id: p1Section.id)

        # Setting Section attributes
        section.is_in_person = singleSection['instructionMode']
        section.campus_name = singleSection['campus']
        section.term = singleSection['term']

        # Course attribute to be added after loop
        @courseHasLab = singleSection['component']

        # sectionMeetings is an array of meetings
        sectionMeetings = singleSection['meetings']

        # Parsing through each meeting
        sectionMeetings.each do |meeting|
          # Adding Section attributes
          # section. = meeting["buildingDescription"]
          section.start_time = meeting['startTime']
          section.end_time = meeting['endTime']

          # If the day is true then it is appended to a string that holds which days the class meets
          @tempDayString = ''
          @tempDayString += 'M' if meeting['monday']
          @tempDayString += 'Tu' if meeting['tuesday']
          @tempDayString += 'W' if meeting['wednesday']
          @tempDayString += 'Th' if meeting['thursday']
          @tempDayString += 'F' if meeting['friday']
          @tempDayString += 'Sa' if meeting['saturday']
          @tempDayString += 'Su' if meeting['sunday']

          section.day = @tempDayString

          # meetingInstructors is an array of instructors
          meetingInstructors = meeting['instructors']

          # Parsing through instuctors
          meetingInstructors.each do |instructor|
            instuctorEmail = instructor['email']
            instructorFirstName, instructorLastName = instructor['displayName'].split(' ') if instructor['displayName']

            # If the User already exists there is no need to try to put them in the database
            unless User.exists?(email: instuctorEmail)
              p1User = User.create email: instuctorEmail, password: 'password',
                                   password_confirmation: 'password', first_name: instructorFirstName, last_name: instructorLastName, role: 1, approved: false
            end

            # Adding entry in SectionInstructor table
            p1SectionInstructor = SectionInstructor.create section_id: p1Section.id,
                                                           instructor_email: instuctorEmail
          end

          section.num_graders_needed = 1
        end

        # Adding the has_lab value into the Course
        course = Course.find_by(id: @tempCourseID)
        course.has_lab = @courseHasLab
        course.save

        # Saving section into the DB
        section.save
      end
    end
  end
end
