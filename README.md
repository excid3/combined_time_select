Combined Time Select
====================

Written by [Chris Oliver](http://excid3.com) [@excid3](https://twitter.com/excid3).

This is a small gem for creating Google Calendar style 12 hour AM/PM
time_select fields for Rails 3. It's based off of [simple_time_select](https://github.com/tamoyal/simple_time_select) by tamoyal.

![combined_time_select](http://f.cl.ly/items/1945331M3W1h0f1K3I2v/Screen%20Shot%202011-12-23%20at%2012.08.37%20AM.png)

![combined_time_select](http://f.cl.ly/items/0H1x3a0S3m3E1U020s2m/Screen%20Shot%202011-12-23%20at%2012.09.00%20AM.png)

Installation
------------

Just add this into your Gemfile followed by a bundle install:

    gem "combined_time_select", "~> 1.0.1"

Usage
-----

Here we have a model called Event with the start_time attribute that we
will be using with combined_time_select.

Because Rails time_select fields submit separate values, there is some
overhead on the controller side when we combine the fields into one. We
can't rely on Rails to parse the input into a valid time anymore.

In the view you can do the following:

    <%= f.time_select :start_time,
      :combined => true,
      :default => Time.now.change(:hour => 11, :min => 30),
      :minute_interval => 15,
      :time_separator => "",
      :start_hour => 10,
      :start_minute => 30,
      :end_hour => 14,
      :end_minute => 30
    %>

This will create a combined time select starting at 10:30 AM and going till
2:30 PM with 15 minute intervals with a default of 11:30 AM. This will set the
value for the start_time attribute on the object this form was created
for.

On the controller side, we need to parse this attribute before we create
a new object. combined_time_select provides a nice method for this
called parse_time_select!. You can use this in your create action just
before you initialize the new model:

    def create
      params[:event].parse_time_select! :start_time
      @event = Event.new params[:event]
    end

    def update
      params[:event].parse_time_select! :start_time
      @event = Event.find(params[:event])
      if @event.update_attributes params[:event]
        ...
      end
    end

And voila! You're all set.

Behind The Scenes
-----------------

When the form gets submitted we will recieve a params hash like so:

    {"utf8"=>"✓", "event"=>{"start_time(5i)"=>"10:00:00"}, "commit"=>"Save changes"}

A normal time_select wil use start_time(4i) for the hours and
start_time(5i) for the minutes. The parse_time_select! will take all the
start_time(Xi) fields, parse them into a Time object and set the
params[:start_time] attribute to this object. The result after a
parse_time_select!(attribute) looks like this:

    {"utf8"=>"✓", "event"=>{"start_time"=>Fri, 23 Dec 2011 10:00:00 UTC +00:00}, "commit"=>"Save changes"}

This allows you to also seamlessly use a date_select field in
combination with combined_time_select.


