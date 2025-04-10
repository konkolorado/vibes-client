# frozen_string_literal: true

require 'thor'

# A class to provide valid help messages for nested thor commands
# Taken from https://github.com/rails/thor/wiki/Subcommands#subcommands-that-work-correctly-with-help
class SubCommandBase < Thor
  def self.banner(command, _ = nil, _ = false)
    "#{basename} #{subcommand_prefix} #{command.usage}"
  end

  def self.subcommand_prefix
    name.gsub(/.*::/, '').gsub(/^[A-Z]/) do |match|
      match[0].downcase
    end.gsub(/[A-Z]/) { |match| "-#{match[0].downcase}" }
  end
end
