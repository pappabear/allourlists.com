class NewUserEmail < MailForm::Base


  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message


  def headers
    {
        :subject => %("#{name}") + " just joined AllOurLists",
        :to => "allourlists.strategem@gmail.com",
        :from => %("#{name}" <#{email}>)
    }
  end


end