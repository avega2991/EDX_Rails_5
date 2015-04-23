require_relative '../mailers/my_mailer'

class ResqueTestJob

  @queue = :resque_test

  def self.perform(filename, search_word, email)

    @string_array = Array.new

    File.open("#{Rails.root}/#{filename}", 'r') do |file|
      while (line = file.gets) do

        if (line =~ /(\s+|^)#{search_word}(\s+|$)/)
          @string_array.push(line)
        end

      end
    end

    @new_filename = 'new_file.txt'
    new_file = File.new(@new_filename, 'w')

    File.open(new_file, 'w') do |file|
      @string_array.each do |string|
        file.write string
      end
    end

    MyMailer.welcome_email(email, @new_filename).deliver!

    puts "Mail has been sended"

  end

end