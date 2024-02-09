puts 'Event Manager Initialized!'


# "my" CSV parser
contents = File.readlines('event_attendees.csv') if File.exist? 'event_attendees.csv'

contents.each_with_index do |line, index|
  next if index == 0
  data = line.split(",")
  name = data[2]
  puts name
end


# buiild in parser
puts "\n Build in parser \n\n"

require 'csv'
require 'google/apis/civicinfo_v2'

def clean_zipcodes zipcode
    zipcode.to_s.rjust(5, '0')[0..4]
end

def check_phone phone_number
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == 1
    phone_number[1..9]
  else
    "Bad phone number (lenght must be 10)"
  end
end

def legislators_by_zipcode zipcode
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials

    legislator_names = legislators.map(&:name)

    legislators_string = legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

contents.each do |line|
  name = line[:first_name]

  zipcode = clean_zipcodes(line[:zipcode])

  phone_number = check_phone(line[:homephone].to_s.tr("-.() ", ""))

  legislators = legislators_by_zipcode zipcode

  puts "#{name} #{zipcode} #{phone_number} #{legislators}"
end
