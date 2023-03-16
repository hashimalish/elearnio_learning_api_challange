# README

## Getting Started
To get started with the app, clone the repo and then

## Pre-requisits
- Ruby '3.0.1'
- Rails '6.1.7'
- Postgresql '~> 1.1'

#### install the needed gems:
```
$ gem install bundler
$ bundle install 
```

### Migrate the database:
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```
### Run the test suite
```
$ rails test
```
### Run app/server
```
$ rails server
```
# API Endpoints

## Learning Paths

- `GET /learning_paths`
  Returns a list of all learning paths.

- `GET /learning_paths/:id`
  Returns a specific learning path based on ID.

- `POST /learning_paths`
  Creates a new learning path.

```
  Request Body
  {
  "learning_path": {
    "name": "Example Learning Path",
    "course_ids": [1, 2, 3]
    }
  }

```

- `PATCH /learning_paths/:id`
  Updates an existing learning path.

```
  Request Body
  {
  "learning_path": {
    "name": "Example Learning Path",
    "course_ids": [1, 2, 3]
    }
  }

```

- `DELETE /learning_paths/:id`
  Deletes a specific learning path based on ID.

- `POST /learning_paths/:id/add_course/:course_id`
  Adds a course to a specific learning path based on ID.

## Authors

- `GET /authors`
  Returns a list of all authors.

- `GET /authors/:id`
  Returns a specific author based on ID.

- `POST /authors`
  Creates a new author.

```
  Request Body
  {
  "author": {
    "name": "Example Author",
    }
  }

```

- `PATCH /authors/:id`
  Updates an existing author.

```
  Request Body
  {
  "author": {
    "name": "New Author Name"
    }
  }

```

- `DELETE /authors/:id?:replacement_author_id`
  Deletes a specific author based on ID and replaces with specific author provided.


## Courses

- `GET /courses`
  Returns a list of all courses.

- `GET /courses/:id`
  Returns a specific course based on ID.

- `POST /courses`
  Creates a new course.

```
  Request Body
  {
  "course": {
    "name": "New Course",
    "learning_path_id": "1",
    # You can pass the id of an author/talent here
    "author_id": "2"
    }
  }

```

- `PATCH /courses/:id`
  Updates an existing course.

```
  Request Body
  {
  "course": {
    "name": "New Course",
    "learning_path_id": "1",
    # You can pass the id of an author/talent here
    "author_id": "2"
    }
  }

```

- `DELETE /courses/:id`
  Deletes a specific course based on ID.


## Talents

- `GET /talents`
  Returns a list of all courses.

- `GET /talents/:id`
  Returns a specific talent based on ID.

- `POST /talents`
  Creates a new talent.

```
  Request Body
  {
  "talent": {
    "name": "New Talent",
    "learning_path_ids": [1,2,3]
    }
  }

```

- `PATCH /talents/:id`
  Updates an existing talent.

```
  Request Body
  {
  "talent": {
    "name": "New Talent",
    "learning_path_ids": [1,2,3]
    }
  }

```

- `DELETE /talents/:id`
  Deletes a specific talent based on ID.

- `PATCH /talents/:id/assign_learning_path/:learning_path_id`
  Assigns a learning path to the talent with the given ID.

- `POST /talents/:id/courses/:course_id/mark_completed`
  Marks a course as completed for the talent with the given ID.


# Improvements/Suggestions
- We could use swagger or postman docs to add documentation for this API
- We can add authentication
- We can add authorizatoin and roles based access
