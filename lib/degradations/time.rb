require 'fileutils'
require 'pry'

# params:
#  {
#    rate: 0.05
#  }
class Degradations::Time < DegradationProcess
  def run(params)
    `rubberband --time  #{params[:rate]} #{@audio.file_path} #{@audio.file_path}.time`
    FileUtils.mv(@audio.file_path, "#{@audio.file_path}.old")
    FileUtils.mv("#{@audio.file_path}.time", @audio.file_path)
  end
end
