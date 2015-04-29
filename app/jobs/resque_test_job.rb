require_relative '../mailers/my_mailer'

class ResqueTestJob
  include Resque::Plugins::Status

  @queue = :resque_test

  def perform

    @string_array = Array.new

    File.open("#{options['filename']}", 'r') do |file|
      while (line = file.gets) do

        if (line =~ /(\s+|^)#{options['word']}(\s+|$)/)
          @string_array.push(line)
        end

      end
    end

    @new_filename = "/tmp/new_file.txt"
    new_file = File.new(@new_filename, 'w')

    File.open(new_file, 'w') do |file|
      @string_array.each do |string|
        file.write string
      end
    end

    MyMailer.welcome_email(options['email'], @new_filename).deliver!

    puts "Mail has been sended"

  end

end