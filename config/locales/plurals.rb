{
  ua: {
    i18n: {
      plural: {
        keys: %i[one few other],
        rule: lambda { |n|
          if n % 10 == 1 && n % 100 != 11
            :one
          elsif [2, 3, 4].include?(n % 10) && [12, 13, 14].exclude?(n % 100)
            :few
          else
            :other
          end
        }
      }
    }
  }
}
