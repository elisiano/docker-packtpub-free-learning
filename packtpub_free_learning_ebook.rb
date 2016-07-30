#!/usr/bin/env ruby

require 'mechanize'
require 'washbullet'
require 'date'

if ENV['PP_EMAIL'].empty?
	puts "missing PacktPub email address environment variable (PP_EMAIL)"
	exit 1
end

if ENV['PP_PASSWORD'].empty?
	puts "missing PacktPub password environment variable (PP_PASSWORD)"
	exit 1
end


mechanize = Mechanize.new

page = mechanize.get('https://www.packtpub.com/packt/offers/free-learning')
loggedin_page = page.form_with(:id => 'packt-user-login-form') do |form|
	email_field = form.field_with(:id => 'email')
	email_field.value = ENV['PP_EMAIL']

	password_field = form.field_with(:id => 'password')
	password_field.value = ENV['PP_PASSWORD']
end.submit

if ! ENV['PB_EMAIL'].empty? and ! ENV['PB_TOKEN'].empty?
	puts "Sending notification to " + ENV['PB_EMAIL'] + " via pushbullet..."
	title = page.at('.dotd-title h2').inner_text.strip
	link = page.link_with(:href => /freelearning-claim/)
	page = link.click
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
