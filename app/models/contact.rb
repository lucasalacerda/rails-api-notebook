class Contact < ApplicationRecord

    # Associations 
    belongs_to :kind #, optional: true
    #has_many: o model precisa estar no plural. Por isso ":phones"
    has_many :phones 
    #has_one: o model precisa estar no singular. Por isso ":address"
    has_one :address
    
    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true
    validates :email, :presence => true, :uniqueness => true
=begin
    def birthdate_br
        I18n.l(self.birthdate) unless self.birthdate.blank?
    end
=end
    def to_br
        { 
            name: self.name,
            email: self.email, 
            birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?)
        }
    end

    def as_json(options={})
        h = super(options)
        h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
        h
    end
=begin
    #quando tem o belongs_to com flag optional, é possível salvar contato sem informar o kind

    def author
        "Lucas Lacerda"
    end

    def kind_description
        self.kind.description
    end

    def as_json(option={})
        super(
            root: true,
            methods: [:kind_description, :author],
        )
    end

    def hello
        I18n.t('hello')
    end

    def i18n
        I18n.default_locale
    end

    def as_json(option={})
        super(
            root: true,
            methods: :author,
            include: { kind: {only: :description}}
        )
    end
=end
end
