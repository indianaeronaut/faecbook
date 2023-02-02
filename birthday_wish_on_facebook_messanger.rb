require 'cucumber'
require 'watir'
require 'webdrivers'

@browser = Watir::Browser.start "<faecbook url>", :chrome , options: {args: ['--disable-notifications']}

@browser.text_field(id: 'email').wait_until(&:present?).set('<your_email>')
@browser.text_field(id: 'pass').wait_until{|ele| ele.present?}.set('your_password')
@browser.button(name: 'login').wait_until(&:present?).click

# Birthday page
@browser.goto('https://www.facebook.com/events/birthdays') 
# 'Today's birthdays' section:
@todays_bd_div = @browser.div(class: 'x1oo3vh0 xexx8yu x1pi30zi x18d9i69 x1swvt13', index: 0) 

# Send birthday greetings on messanger for the person having wall posting disabled
@num_messeger = @todays_bd_div.divs(aria_label: "Message").size
@num_messeger

if @num_messeger == 0
    puts "No one, celibrating birthday today, have disabled wall posting."
else
    i = 0
    @todays_bd_div.divs(aria_label: "Message").each do
        @button_messeger = @todays_bd_div.div(aria_label: "Message", index: i)
        @button_messeger.click # Opens messenger
     
        # Identify text_field element in messanger and send the message:
        @textbox_messanger = @browser.div(class: 'xmjcpbm x107yiy2 xv8uw2v x1tfwpuw x2g32xy x9f619 x1iyjqo2 xeuugli').child.child.child
        @textbox_messanger.wait_until(&:present?).set("HBD!")
        @textbox_messanger.send_keys :enter
        sleep 2
        @textbox_messanger.send_keys :escape
        i += 1

    end
    puts "Birthday wishes sent on messanger."
end

