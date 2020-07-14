# テストユーザーとしてログインする
def log_in_path(user, password: user.password, remember_me: '1')
  post login_path, params: { session: { email: user.email,
                                        password: password,
                                        remember_me: remember_me } }
end

def log_in_as(user, password: user.password, remember_me: '1')
  visit login_path
  fill_in "メールアドレス", with: user.email
  fill_in "パスワード", with: password
  click_button "ログイン"
end
