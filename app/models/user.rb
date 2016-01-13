class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
    
    attr_accessible :email

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true


    before_create :create_referral_code
    before_create :add_to_list
    after_create :send_welcome_email

    REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "15%<br>off",
            "class" => "two",
            "image" =>  ActionController::Base.helpers.asset_path("refer/happycumar.gif")
        },
        {
            'count' => 10,
            "html" => "25%<br>off",
            "class" => "three",
            "image" => ActionController::Base.helpers.asset_path("refer/donny.gif")
        },
        {
            'count' => 25,
            "html" => "50%<br>off",
            "class" => "four",
            "image" => ActionController::Base.helpers.asset_path("refer/jimmyfallon.gif")
        },
        {
            'count' => 50,
            "html" => "Get the <br> course free!",
            "class" => "five",
            "image" => ActionController::Base.helpers.asset_path("refer/kermit.gif")
        }
    ]
   def add_to_list
      list_id = "715a1cd50a"
      @gb = Gibbon::Request.new
      subscribe = @gb.lists(list_id).members.create(body: {
        email_address: self.email, 
        status: "subscribed", 
        double_optin: false
        })
    end
    private
  
    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

    def send_welcome_email
        UserMailer.delay.signup_email(self)
    end
end
