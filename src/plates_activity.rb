# encoding: utf-8

require 'ruboto/widget'
require 'ruboto/util/toast'
require 'plates_repository'

ruboto_import_widgets :EditText, :TextView, :Button, :LinearLayout

class PlatesActivity
  def on_create(bundle)
    super

    handle_click = proc do |view|
      prefix = @text_field.getText.to_s
      result = begin
        PlatesRepository.new.find_by_prefix(prefix)
      rescue PlatesRepository::NotFound
        'not found'
      end
      @text_field.text = ''
      @tv.text         = "#{prefix.upcase} - #{result}"
    end

    setContentView(
      linear_layout(:orientation => :vertical) do
        @text_field = edit_text
        linear_layout do
          button :text => "Check", :on_click_listener => handle_click
        end
        @tv = text_view :text => "Enter plate prefix:"
      end
    )
  rescue
    puts "Exception: #{$!}"
    puts $!.backtrace.join("\n")
  end
end
