module Account::UtilityProvidersHelper
  COMPANY_TYPE_ICONS = {
    Company::WATER_SUPPLY => { class: "tint", color: "#0a95ff" },
    Company::HEATING => { class: "fire", color: "#e38e42" },
    Company::RENT_PAYMENT => { class: "building", color: "#8b9fa6" },
    Company::ACCOMMODATION_PAYMENT => { class: "city", color: "#6d828a" },
    Company::GAS => { class: "fire-alt", color: "#ff8b33" },
    Company::ELECTRICITY => { class: "bolt", color: "#33b4ff" },
    Company::GARBAGE_REMOVAL => { class: "dumpster", color: "#ff6f59" },
    Company::INTERNET => { class: "wifi", color: "#3392ff" },
    Company::INTERCOM => { class: "blender-phone", color: "#ad0aff" },
    Company::TV => { class: "tv", color: "#42a647" },
    Company::ELEVATOR => { class: "tram", color: "#79a7b3" },
    Company::OTHER => { class: "question-circle", color: "#c28a8a" }
  }.freeze

  def icon_for_company(type)
    if COMPANY_TYPE_ICONS[type].nil?
      COMPANY_TYPE_ICONS[Company::OTHER]
    else
      COMPANY_TYPE_ICONS[type]
    end
  end
end
