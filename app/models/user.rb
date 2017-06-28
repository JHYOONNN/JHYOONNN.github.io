class User < ActiveRecord::Base
  #새로운 유저, 2명째 부터는 권한을 default로 설정합니다
  after_create :set_default_role, if: Proc.new { User.count > 1 }

  #rolify기능을 사용합니다 
  rolify

  #devise로 인해 사용할 수 있는 함수들입니다  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #모델에서의 관계입니다
  has_many :posts

  #기본 권한을 지정하는 함수입니다
  def set_default_role
    add_role :user
  end
end