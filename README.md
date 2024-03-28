# Course Catalog Manager

The course catalog manager allows users to be able to browser computer science and engineering courses offered by The Ohio State Uniiversity from all campuses with various sorting/filtering options to allow for easy user navigation.

With this application, there are 3 different types of users: student, instructor, and admin. On sign-up, all of the users will be able to browse the course catalog, but admins and instructors will need to be approved to access extra functionalities.

Admins have extra functionalities that allow them to approve other admins/instructors, add, remove, or edit a course/section, and reload the course catalog.

___

## Install and Run Course Catalog Manager

### Dependencies

- Command line prompt (ex: Terminal for Mac, Ubuntu for Windows)
    - For assistance installing Ubuntu visit: https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview.
- Ruby version 3.2.0
    - For assistance installing ruby visit: https://www.ruby-lang.org/en/documentation/installation/.
- Rails version 7.0.4
    - For assistance installing rails visit: https://guides.rubyonrails.org/v5.0/getting_started.html.
- "Gemfile" contains the remaining gems needed to run this application. These can be downloaded by typing "bundle" in the command line prompt during the installation process.

### Installation

1. Download the zip file containing all source code within this repository. This can be done by clicking on the green "Code" button on the main repository page and selecting "Download ZIP" from the dropdown.
2. Navigate to the zip file (often can be found within your downloads folder or at the bottom of your browser window) and unzip the file. Below is  ways in which you can unzip the file on various Operating Systems.
    - ***Mac***
        - Double click on the .zip file, the unzipped item will appear in the same location as the .zip file.
    - ***Windows***
        - Right click on the .zip file and select "Extract All", then follow the instructions.
    - ***Linux***
        - Using a GUI
            - Right click on the .zip file and select "Extract Here", the file will be placed in the working directory.
        - Using the command line
            - ***Requires Installation of the unzip command***
                - To install unzip type "sudo apt-get install unzip" into the terminal.
            - Navigate to the directory in which the .zip file is located. Type "unzip {name}.zip" (in which {name} is replaced with the name of the .zip file) into the terminal and hit enter. The unzipped file should then be in the working directory.
3. Open the applications directory in the command line prompt by using the "cd" command followed by the name of the unzipped folder (ex: Team-2-Lab-2-main) in the directory that you unzipped the file.
4. Install the remaining gems by typing "bundle" into the command line prompt.
5. Initialize the database by typing "rails db:migrate" into the command line prompt.
6. Add the predetermined seeded users by typing "rails db:seed" into the command line prompt.
7. Run the server by typing "rails s" into the command line prompt.
8. Open the url provided after "Listening on" (ex. http://127.0.0.1:3000) by typing it into any web browser.

___

## How to Use

### Signing Up / Signing in

- **Predetermined Logins**
    - ***Approved Admin***
        - *Email*: admin.1@osu.edu
        - *Password*: password

    - ***Pending Approval Admin***
        - *Email*: admin.2@osu.edu
        - *Password*: password

    - ***Approved Instructor***
        - *Email*: instructor.1@osu.edu
        - *Password*: password

    - ***Pending Approval Instructor***
        - *Email*: instructor.2@osu.edu
        - *Password*: password

    - ***Student***
        - *Email*: student.1@osu.edu
        - *Password*: password

- Before a user is able to access the course catalog, they must sign-in or sign-up if this is their first time accessing the page. To sign-up, the user can click the "sign-up" link below the login button. On the sign-up page, users can now select their desired role (instructors and admins will need approval from an existing admin for additional features) and fill in their information using only their OSU email (ex: name.##@osu.edu).

- Forgotten passwords can be reset by clicking on the "Forgot your password?" link below the "sign-up" link to receive an email with instructions how to reset their password.

- When logged in, user account information can be edited or deleted by hovering over the "Account" in the top right of the navigation bar, then selecting the "Edit Account" button from the drop-down menu.

### Homepage

- The homepage contains links to the relevant pages that a user can access as well as the top navigation bar with additional links. The appearance of the homepage and navigation bar will change depending on the user type and approval status.


### Browse

- The catalog page contains all of the computer science and engineering courses offered by the various campuses at The Ohio State University. By default, it will display all of the courses available for the Autumn, Spring, and Summer semesters for every campus. Specificities of courses and sections can be filtered by typing the course number in the search bar or selecting values from any of the drop-down menus then selecting the search button.

- To view specific information about a course, such as its sections, select the "view" link located on the right of the course.

### Admin Functionalities

- Admin functionalities can be found by hovering over the "Admin Control" in the top navigation bar, then selecting a functionality in the drop-down menu. However, editing a specific course/section can be done by in the views of the course/section they wish to be changed.

1. #### Admin Reload

    - Admins can reload parts of the course catalog by selecting a semester and campus from the drop-down menus then selecting the "Reload Data" button. After the reload is complete, the user will be redirected to the catalog to view the updated catalog.

    - Ex: Selecting Summer 2023 and Columbus will reload the course data for only the Columbus campus for the Summer 2023 semester.

2. #### Approve Users

    - Admins and instructors waiting to be approved will appear on this page. An admin user can select either "approve" to give the user access to extra functionalities or "deny" to delete the users account. Denied users must sign-up again to request additional permissions.

3. #### Add Course/Section

    - Courses/Sections can be added to the catalog by filling in the new course/section information on the page then selecting the "submit" button at the bottom. This will redirect the user to the specific course/section page they just added.

4. #### Editing a Course/Section

    - Courses can be edited by searching for the course in the catalog browser. By selecting the "view" link next to a course, this will display the course information. The course can be edited or deleted by clicking on the respective links at the top of the course page.
    - Sections of a course can be edited or deleted by clicking on the respective links in the section column of the course information page.

5. ### Evaluations for Instructors

    - Evaluations can be created and viewed by admins and instructors. This can be acheived via the "Instructor Evaluation" tab in the navigation bar or the home screen. These evaluations are indexed for the admins for a later date, so graders with good evaluations can take priority over those with not.

6. ### Instructor Recommendations

    - Admins and instructors can recommend a student for grading via the "Instructor Recommendation" tab in the navigation bar or the homescreen. These recommendations
    are also visible in bulk via the "view recommendations" tab. Admins and instructors, within the recommendation form, have the ability to either specifically request an indivudal to grade for a specific section, via a specific request flag, or to simply endorse a student as a grader.

7. ### Grader Assignment

    - Admins can view all courses requiring graders via the "Section Instructors" tab in the navigation bar or the homescreen. In this tab, admins may also view all pending
    student applications to grade, and assign graders to specific sections. In this view, it is also possible for admins to change the number of graders needed, by simply editing the section itself.

8. ### Automated Emails

    - In the case where a user is referenced in an instructor recommendation and we do not have record of that user, we will send an email to a provided address.
    An email will also be sent to a user address upon account approval, account denial, and grader application acceptance.

9. ### Student Functionalities

    - Students may manipulate their standing on the webpage by submitting applications for grading, adding schedule avaibility, and adding a list of courses they have completed. Additionally, students may add a perferred course of their choosing to their application, this perferred course being chosen from the subset that is all of their completed courses. This functionalities can be found in the student section on the navigation bar, or the home screen.
___

## Troubleshooting

- Loading in the initial course information for all of the campuses and semesters can take a while. Please be patient while the data is being loaded after a user signs in. If your internet connection is interrupted during this process, close the server using "control + c" in the command line prompt, then reset the database using the following commands and try again:
    1. rails db:drop:all
    2. rails db:create:all
    3. rails db:migrate
    4. rails db:seed
- If the initial loading of the course information did not fully complete:
    1. Sign in with the predetermined approved admin login.
    2. Navigate to the "Admin Reload" page.
    3. Reload each of the desired semesters and campuses individually.
