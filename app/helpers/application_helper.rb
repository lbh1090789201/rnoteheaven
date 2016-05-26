module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Ryunkang"
    end
  end

  def sms(telphone, content)
    params = {
        userid: '385',
        account: 'luyun',
        password: '666666',
        mobile: telphone,
        content: content,
        action:'send',
    }
    url = 'http://120.24.241.49/sms.aspx'
    #   Foo.post('http://foo.com/resources', query: {bar: 'baz'})

    response = HTTParty.get(url, query: params)
    rep = response['returnsms']
    puts rep
    if rep['returnstatus'] == 'Faild'
      return false
    end
    return true
  end

# send notice to page
  def notice_message
      alert_types = { notice: :success, alert: :danger }
      close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
      close_button = content_tag(:button, "x", close_button_options)
      alerts = flash.map do |type, message|
        alert_content = close_button + message
        alert_type = alert_types[type.to_sym] || type
        alert_class = "alert alert-#{alert_type} alert-dismissable"
        content_tag(:div, alert_content, class: alert_class)
      end
      alerts.join("\n").html_safe
  end

  # 列表排序
  def sortable(column, title)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end
