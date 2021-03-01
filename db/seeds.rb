# メインのサンプルユーザーを1人作成する
# User.create!(name:  "Example User",
#               email: "example@railstutorial.org",
#               password:              "foobar",
#               password_confirmation: "foobar",
#               admin: true,
#               activated: true,
#               activated_at: Time.zone.now)

# User.create!(name:  "Test User",
#               email: "test@railstutorial.org",
#               password:              "foobar",
#               password_confirmation: "foobar",
#               admin: false,
#               activated: true,
#               activated_at: Time.zone.now)

dishes = { breakfast: [[ {name: "食パン", category: "主菜"},
                        {name: "ベーコンチーズエッグ", category: "副菜"},
                        {name: "バナナ", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ],
                      [ {name: "ハムチーズ食パン", category: "主菜"},
                        {name: "バナナ", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ],
                      [ {name: "マーマレード食パン", category: "主菜"},
                        {name: "バナナ", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ],
                      [ {name: "チーズハヤシパン", category: "主菜"},
                        {name: "バナナ", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ],
                      [ {name: "食パン", category: "主菜"},
                        {name: "コーンフレーク", category: "主菜"},
                        {name: "ウインナー", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ],
                      [ {name: "チョココロネ", category: "主菜"},
                        {name: "クリームパン", category: "主菜"},
                        {name: "バナナ", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ],
                      [ {name: "レーズンパン", category: "主菜"},
                        {name: "コーンフレーク", category: "主菜"},
                        {name: "バナナ", category: "副菜"},
                        {name: "ヨーグルト", category: "副菜"} ]],
              lunch: [[ {name: "うどん", category: "主菜"},
                        {name: "筑前煮", category: "副菜"},
                        {name: "かまぼこ", category: "副菜"},
                        {name: "伊達巻", category: "副菜"} ],
                      [ {name: "お雑煮", category: "主菜"},
                        {name: "かまぼこ", category: "副菜"},
                        {name: "黒豆", category: "副菜"} ],
                      [ {name: "鮭玉子おにぎり", category: "その他"},
                        {name: "ピーマンの肉詰め", category: "主菜"},
                        {name: "がんも", category: "副菜"},
                        {name: "きんぴらごぼう", category: "副菜"},
                        {name: "ブロッコリー", category: "副菜"},
                        {name: "キャベツの千切り", category: "副菜"} ],
                      [ {name: "焼きおにぎり", category: "その他"},
                        {name: "餃子スープ", category: "主菜"},
                        {name: "ごぼうサラダ", category: "副菜"},
                        {name: "おさつちゃん", category: "副菜"} ],
                      [ {name: "鶏の唐揚げ風", category: "主菜"},
                        {name: "かぼちゃ", category: "副菜"},
                        {name: "キャベツの千切り", category: "副菜"} ],
                      [ {name: "天丼", category: "主菜"},
                        {name: "ごぼうサラダ", category: "副菜"} ],
                      [ {name: "炊き込みご飯", category: "その他"},
                        {name: "タレ漬け唐揚げ", category: "主菜"},
                        {name: "シュウマイ", category: "副菜"},
                        {name: "きんぴらごぼう", category: "副菜"},
                        {name: "さつまいもの甘煮", category: "副菜"},
                        {name: "キャベツの千切り", category: "副菜"} ]],
              dinner: [[ {name: "そぼろ丼", category: "主菜"},
                        {name: "大根と油揚げの味噌汁", category: "汁物"},
                        {name: "ほうれん草の胡麻和え", category: "副菜"} ],
                       [ {name: "豚肉と大根の甘煮", category: "主菜"},
                        {name: "白菜の味噌汁", category: "汁物"},
                        {name: "玉子豆腐", category: "副菜"} ],
                       [ {name: "鮭", category: "主菜"},
                        {name: "白菜の味噌汁", category: "汁物"},
                        {name: "かぼちゃ", category: "副菜"},
                        {name: "ピーマンのツナ和え", category: "副菜"} ],
                       [ {name: "コロッケ", category: "主菜"},
                        {name: "白菜とえのきの味噌汁", category: "汁物"},
                        {name: "筑前煮", category: "副菜"} ],
                       [ {name: "焼き鶏肉", category: "主菜"},
                        {name: "玉子と玉ねぎの味噌汁", category: "汁物"},
                        {name: "さつまいも", category: "副菜"},
                        {name: "白菜とえのきと油揚げの煮物", category: "副菜"} ],
                       [ {name: "たけのこご飯", category: "その他"},
                        {name: "エビマヨ", category: "主菜"},
                        {name: "白菜とベーコンのコンソメスープ", category: "汁物"},
                        {name: "長芋のバター焼き", category: "副菜"} ],
                       [ {name: "炒飯", category: "主菜"},
                        {name: "わかめとえのきのコンソメスープ", category: "汁物"},
                        {name: "かぼちゃ", category: "副菜"},
                        {name: "キャベツのツナ和え", category: "副菜"} ]]
}

["朝食", "昼食", "夕食"].each do |time|
  case time
  when "朝食" then
    etime = "breakfast"
  when "昼食" then
    etime = "lunch"
  when "夕食" then
    etime = "dinner"
  end

  7.times do |n|
    menu = Menu.create!(date: Date.today-n-1,
                        time: time,
                        picture: open("./db/fixtures/#{etime}/#{n+1}.jpg"),
                        user: User.find_by(name: "Test User", email: "test@railstutorial.org"))

    dishes[:"#{etime}"][n].each do |dish|
      Dish.create!(name: dish[:name], category: dish[:category], menu: menu)
    end
  end
end
