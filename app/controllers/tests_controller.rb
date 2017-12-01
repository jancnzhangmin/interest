class TestsController < ApplicationController
  require 'uuidtools'
  def index
    ttarr = Array.new
    10.times do
      ttarr.push UUIDTools::UUID.timestamp_create
    end
    debugger
  end

end
