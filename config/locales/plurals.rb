{
  ua: {
    i18n: {
      plural: {
        keys: %i[one few other],
        rule: lambda { |n|
          if n == 1
            :one
          elsif [2, 3, 4].include?(n % 10) &&
                [12, 13, 14].exclude?(n % 100) &&
                [22, 23, 24].exclude?(n % 100)
            :few
          else
            :other
          end
        }
      }
    }
  }
}
