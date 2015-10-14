---

[![Stories in Ready](https://badge.waffle.io/mbburch/the-pivot.png?label=Ready)](http://waffle.io/mbburch/the-pivot)
[![Throughput Graph](https://graphs.waffle.io/mbburch/the-pivot/throughput.svg)](https://waffle.io/mbburch/the-pivot/metrics)
##### [Mimi Schatz](https://github.com/mcschatz), [MB Burch](https://github.com/mbburch), [Adam Jensen](https://github.com/adamki)

The Pivot is the first project in Module 3 at the Turing School. Each group are given a legacy project to work with. We started with a E-commerce site called Denvestments, a micro-lending site. We are pivoting from [Denvestments](https://github.com/russelleh/denvestments).

[Project Outline](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/the_pivot.md) | [Heroku](http://denvestments.herokuapp.com)

### Instructions

* clone the project in your terminal by running `git clone git@github.com:mbburch/the-pivot`
* start the server with `rails s` and visit `http://localhost:3000` in your preferred browser
* to run the tests, run `bundle exec rspec` in the terminal

### Areas of Focus

* Working with Multitenancy
* Implementing JavaScript
* Securing a Rails App
* Sending Email
* Creating Seed files

### Git Workflow

**Starting a new branch**

* checkout a branch named after the waffle story and include the number
* Squash and order commits by spec
* Push branch and tag with [WIP] until story is completed

**Creating a Pull Request**

* close the waffle issue on GitHub
* Notify group members on Slack when PR is ready for code review
* Aim to have the PR reviewed within 45 minutes of submission
* Fix eventual Hound errors before merging the PR
* The group member that merges the PR should
* delete the branch on GitHub
* notify the group members on Slack to pull from master
