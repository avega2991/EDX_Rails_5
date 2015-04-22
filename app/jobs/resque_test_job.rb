require_relative '../mailers/my_mailer'

class ResqueTestJob

  @queue = :resque_test

  def self.perform(filename, search_word, email)

    @string_array = Array.new

    File.open("#{Rails.root}/old_file.txt", 'r') do |file|
      while (line = file.gets) do

        if (line =~ /(\s+|^)#{search_word}(\s+|$)/)
          @string_array.push(line)
        end

      end
    end

    File.open(filename, 'w') do |file|
      @string_array.each do |string|
        file.write string
      end
    end

    MyMailer.welcome_email(email, filename).deliver!

    puts "Mail has been sended"

  end

end