# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#home'

  # define route for admin aprrove_users
  get 'approve', to: 'admin#approve_users'

  # define route for catalog browsing
  get 'catalog', to: 'catalog#catalog', as: 'catalog'


  # ▼▼▼▼▼▼▼▼ Reload ROUTES ▼▼▼▼▼▼▼▼


  # define route for admin reload
  get '/admin_reload', to: 'admin_reload#reload_page', as: 'admin_reload'

  # define route for admin reload post
  post '/admin_reload/reload_page', to: 'admin_reload#reload_page', as: 'admin_reload_reload_page'


  # ▼▼▼▼▼▼▼▼ COURSE ROUTES ▼▼▼▼▼▼▼▼


  # define route for creating a new course
  get 'courses/new', to: 'courses#new'

  # define route for displaying a singular course
  get 'courses/:id', to: 'courses#show', as: 'course_show'

  # define route for displaying the edit screen for a singular course
  get 'courses/:id/edit', to: 'courses#edit', as: 'course_edit'

  # define route for deleting a course of :id
  delete 'courses/:id/delete', to: 'courses#destroy', as: 'course_delete'

  # define route for creating a new course record
  post 'courses/new', to: 'courses#create'

  # patch for editing a course
  patch 'courses/:id/edit', to: 'courses#update'


  # ▼▼▼▼▼▼▼▼ SECTION ROUTES ▼▼▼▼▼▼▼▼


  # define route for creating a new section
  get 'courses/sections/new', to: 'sections#new'

  # define route for displaying a singular section
  get 'courses/sections/:id', to: 'sections#show', as: 'section_show'

  # define route for displaying the edit screen for a singular section
  get 'courses/sections/:id/edit', to: 'sections#edit', as: 'section_edit'

  # define route for deleting a section of :id
  delete 'sections/:id/delete', to: 'sections#destroy', as: 'section_delete'

  # define route for creating a new section record
  post 'courses/sections/new', to: 'sections#create'

  # patch for editing a section
  patch 'courses/sections/:id/edit', to: 'sections#update'

  ###

  # define route for search form
  post :root, to: 'catalog#search', as: 'search'


  # ▼▼▼▼▼▼▼▼ RECOMMENDATION ROUTES ▼▼▼▼▼▼▼▼

  # define route to make new rec
  get 'instructor_recs/new', to: 'instructor_recs#new', as: 'new_instructor_rec'

  # define route to create new rec
  post 'instructor_recs/new', to: 'instructor_recs#create', as: 'create_instructor_rec'

  # define route to index recs
  get 'instructor_recs', to: 'instructor_recs#index', as: 'instructor_recs'

  # define route to delete a rec
  delete 'instructor_recs/:id/delete', to: 'instructor_recs#destroy', as: 'instructor_recs_delete'


  # ▼▼▼▼▼▼▼▼ USER PAGE ROUTES ▼▼▼▼▼▼▼▼


  # define route for users
  get 'users_show', to: 'users#index', as: 'users'

  # define route for deleting a user of :id
  delete 'users/:id/delete', to: 'users#destroy', as: 'user_delete'



  # add approve method to users
  resources :users, param: :email do
    patch :approve, on: :collection
    delete :deny, on: :collection
    delete :remove, on: :collection
  end

  # ▼▼▼▼▼▼▼▼ STUDENT_APP ROUTES ▼▼▼▼▼▼▼▼

  # define route for creating a new student application
  get 'users/student_app/new', to: 'student_apps#new', as: 'student_app_new'

  # define route for displaying a singular student application
  get 'users/student_app/view', to: 'student_apps#show', as: 'student_app_show'

  # define route for displaying the edit screen for a singular student application
  get 'users/student_app/:id/edit', to: 'student_apps#edit', as: 'student_app_edit'

  # define route for deleting a student application of :id
  delete 'users/student_app/:id/delete', to: 'student_apps#destroy', as: 'student_app_delete'

  # define route for creating a student application record
  post 'users/student_app/new', to: 'student_apps#create'

  # patch for editing a student application
  patch 'users/student_app/:id/edit', to: 'student_apps#update'


  # ▼▼▼▼▼▼▼▼ STUDENT_SCHEDULE ROUTES ▼▼▼▼▼▼▼▼


  # define route for creating a new student schedule
  get 'users/student_schedule/new', to: 'student_schedules#new', as: 'student_schedule_new'

  # define route for displaying a singular student schedule
  get 'users/student_schedule/view', to: 'student_schedules#show', as: 'student_schedule_show'

  # define route for displaying the edit screen for a singular student schedule
  get 'users/student_schedule/:id/edit', to: 'student_schedules#edit', as: 'student_schedule_edit'

  # define route for deleting a student schedule of :id
  delete 'users/student_schedule/:id/delete', to: 'student_schedules#destroy', as: 'student_schedule_delete'

  # define route for creating a new student schedule record
  post 'users/student_schedule/new', to: 'student_schedules#create'

  # patch for editing a student schedule
  patch 'users/student_schedule/:id/edit', to: 'student_schedules#update'


  # ▼▼▼▼▼▼▼▼ STUDENT_COURSES_TAKEN ROUTES ▼▼▼▼▼▼▼▼


  # define route for creating a new course taken
  get 'users/student_courses_taken/new', to: 'student_courses_taken#new', as: 'student_courses_taken_new'

  # define route for displaying a singular couse taken
  get 'users/student_courses_taken/view', to: 'student_courses_taken#show', as: 'student_courses_taken_show'

  # define route for displaying the edit screen for a course taken
  get 'users/student_courses_taken/:id/edit', to: 'student_courses_taken#edit', as: 'student_courses_taken_edit'

  # define route for deleting a course taken of :id
  delete 'users/student_courses_taken/:id/delete', to: 'student_courses_taken#destroy',
                                                   as: 'student_courses_taken_delete'

  # define route for creating a new course taken record
  post 'users/student_courses_taken/new', to: 'student_courses_taken#create'

  # patch for editing a course taken
  patch 'users/student_courses_taken/:id/edit', to: 'student_courses_taken#update'


  # ▼▼▼▼▼▼▼▼ SECTION_INSTRUCTORS ROUTES ▼▼▼▼▼▼▼▼


  # define route for displaying all section instructors
  get 'section_instructors', to: 'section_instructors#index', as: 'section_instructor_index'

  # define route for creating a new section instructor
  get 'section_instructor/new', to: 'section_instructors#new', as: 'section_instructor_new'

  # define route for creating a new section instructor prefilled
  get 'section_instructor/new/:section_id', to: 'section_instructors#new', as: 'section_instructor_new_instructor'

  # define route for creating a new section instructor prefilled
  get 'section_instructor/new/:section_id/:instructor_email', to: 'section_instructors#new',
                                                              as: 'section_instructor_new_prefill', constraints: { instructor_email: /([a-z-]+)\.([0-9]+)@osu\.edu/i }

  # define route for displaying a singular section instructor
  get 'section_instructor/:section_id/:instructor_email/view', to: 'section_instructors#show',
                                                               as: 'section_instructor_show', constraints: { instructor_email: /([a-z-]+)\.([0-9]+)@osu\.edu/i }

  # define route for displaying the edit screen for a section instructor
  get 'section_instructor/:section_id/:instructor_email/edit', to: 'section_instructors#edit',
                                                               as: 'section_instructor_edit', constraints: { instructor_email: /([a-z-]+)\.([0-9]+)@osu\.edu/i }

  # define route for deleting a section instructor of :id
  delete 'section_instructor/:section_id/:instructor_email/delete', to: 'section_instructors#destroy',
                                                                    as: 'section_instructor_delete', constraints: { instructor_email: /([a-z-]+)\.([0-9]+)@osu\.edu/i }

  # define route for creating a new section instructor record
  post 'section_instructor/new', to: 'section_instructors#create', as: 'section_instructor_create'

  # patch for editing a section instructor
  patch 'section_instructor/:section_id/:instructor_email/edit', to: 'section_instructors#update',
                                                                 constraints: { instructor_email: /([a-z-]+)\.([0-9]+)@osu\.edu/i }

  # ▼▼▼▼▼▼▼▼ Assign Grader ROUTES ▼▼▼▼▼▼▼▼


  # define route for assign_graders all_student_info
  get 'assign_grader', to: 'assign_grader#all_applicant_info', as: 'assign_grader'

  # define route for assign_graders assign_to_section
  get 'assign_grader/:id', to: 'assign_grader#assign_to_section', as: 'assign_to_section',
                           constraints: { id: /([a-z-]+)\.([0-9]+)@osu\.edu/i }

  # define route for sections needing graders
  get 'sections_need_graders', to: 'assign_grader#assign_to_section', as: 'sections_need_graders'

  # define routes for rest of model's controllers
  resources :courses
  resources :instructor_recs
  resources :recommended_students
  resources :sections
  resources :evaluations
end
