#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../test_helper'
require "set"

class TestStashes < Test::Unit::TestCase
  def setup
    set_file_paths
  end
  
  def test_status_ignore_not_regular_files
    in_temp_dir do |path|
      g = Git.clone(@wbare, 'status_test')
      Dir.chdir('status_test') do
        assert_equal([], g.status.untracked)

        # ignore pipe file.
        system("mkfifo", "--mode=600", "pipe-file")
        assert_equal([], g.status.untracked)
      end
    end
  end
end
