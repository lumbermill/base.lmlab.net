class Mailer < ApplicationMailer
  def simple(from,to,subject,content)
    from = ApplicationMailer.default[:from] if from.nil?
    @content = content
    mail(from: from, to: to, subject: subject) do |format|
      format.text { render 'simple' }
    end
  end
end
