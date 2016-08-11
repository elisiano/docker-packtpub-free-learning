#!/usr/bin/env ruby

require 'mechanize'
require 'washbullet'
require 'date'

if ! ENV.has_key?('PP_EMAIL') or (ENV['PP_EMAIL']).nil?
	puts "missing PacktPub email address environment variable (PP_EMAIL)"
	exit 1
end

if ! ENV.has_key?('PP_PASSWORD') or (ENV['PP_PASSWORD']).nil?
	puts "missing PacktPub password environment variable (PP_PASSWORD)"
	exit 1
end


mechanize = Mechanize.new

page = mechanize.get('https://www.packtpub.com/packt/offers/free-learning')
title = page.at('.dotd-title h2').inner_text.strip
loggedin_page = page.form_with(:id => 'packt-user-login-form') do |form|
	email_field = form.field_with(:id => 'email')
	email_field.value = ENV['PP_EMAIL']

	password_field = form.field_with(:id => 'password')
	password_field.value = ENV['PP_PASSWORD']
end.submit

begin
	link = page.link_with(:href => /freelearning-claim/)		
	page = link.click
rescue
	abort("A problem occured simulating the click")
end
puts "Adding " + title + " to library"

if ENV.has_key?('PB_EMAIL') and ! (ENV['PB_EMAIL']).empty? and ENV.has_key?('PB_TOKEN') and ! (ENV['PB_TOKEN']).empty?
	puts "Sending notification to " + ENV['PB_EMAIL'] + " via pushbullet..."
	pb_client = Washbullet::Client.new(ENV['PB_TOKEN'])
	today = DateTime.now.strftime("%d-%m-%Y")
	pb_client.push_note(
		receiver: :email,
		identifier: ENV['PB_EMAIL'],
		params: {
			title: 'Packtpub ' + today + ' book',
			body: title
		}
	)
end
