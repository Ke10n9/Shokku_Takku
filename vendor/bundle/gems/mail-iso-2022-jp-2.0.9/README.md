mail-iso-2022-jp
================

A patch that provides 'mail' gem with iso-2022-jp conversion capability.

Overview
--------

* (en)

    `mail-iso-2022-jp` is a patch for [mikel/mail](https://github.com/mikel/mail).
    With this patch, you can easily send mails with `ISO-2022-JP` enconding (so-called "JIS-CODE").

* (ja)

    `mail-iso-2022-jp` は、[mikel/mail](https://github.com/mikel/mail) に対するパッチです。
    これを利用すると `ISO-2022-JP`（いわゆる「JISコード」）でのメール送信が容易になります。


Feature
-------

* (en)

    * If you set the `charset` header to `ISO-2022-JP`, the values of `From`, `Sender`, `To`, `Cc`,
    `Reply-To`, `Subject`, `Resent-From`, `Resent-Sender`, `Resent-To` and `Resent-Cc` headers
    and the text of body will be automatically converted to `ISO-2022-JP`.

    * The text part of multipart mail is also encoded with iso-2022-jp.

    * When the `charset` header has other values, this patch has no effect.

* (ja)

    * chasetヘッダの値が `ISO-2022-JP` である場合、差出人(From)、Sender、宛先(To)、Cc、Reply-To、件名(Subject)、
    Resent-From、Resent-Sender、Resent-To、Resent-Cc の各ヘッダの値および本文(Body)が
    自動的に `ISO-2022-JP` に変換されます。

    * マルチパートメールのテキストパートもiso-2022-jpでエンコードされます。

    * charsetヘッダの値が `ISO-2022-JP` でない場合、このパッチには何の効果もありません。

Requirements
------------

### Ruby ###

* 2.2, 2.3, 2.4, 2.5

### Gems ###

* `mail` 2.2.6 or higher, but lower than or equal to 2.7.0

### ActionMailer (Optional) ###

* 3.0 or higher (including 5.x)

Getting Start
-------------

### Install as a gem ###

Add to your Gemfile:

    gem 'mail-iso-2022-jp'

or run this command:

    gem install mail-iso-2022-jp

### Install as a Rails plugin ###

	$ cd RAILS_ROOT
	$ rails plugin install git://github.com/kuroda/mail-iso-2022-jp.git

### Usage ###

    mail = Mail.new(:charset => 'ISO-2022-JP') do
      from    '山田太郎 <taro@example.com>'
      to      '佐藤花子 <hanako@example.com>'
      cc      '事務局 <info@example.com>'
      subject '日本語件名'
      body    '日本語本文'
    end

	mail['from'].encoded
	  => "From: =?ISO-2022-JP?B?GyRCOzNFREJATzobKEI=?= <taro@example.com>\r\n"
	mail['to'].encoded
	  => "To: =?ISO-2022-JP?B?GyRCOjRGIzJWO1IbKEI=?= <hanako@example.com>\r\n"
	mail.subject
	 => "=?ISO-2022-JP?B?GyRCRnxLXDhsN29MPhsoQg==?="
	NKF.nkf('-mw', mail.subject)
	 => "日本語件名"
	mail.body.encoded
	 => "\e$BF|K\\8lK\\J8\e(B"
	NKF.nkf('-w', mail.body.encoded)
	 => "日本語本文"

### Usage with ActionMailer ###

	class UserMailer < ActionMailer::Base
	  default  :charset => 'ISO-2022-JP',
	    :from => "山田太郎 <bar@example.com>",
	    :cc => '事務局 <info@example.com>'

	  def notice
	    mail(:to => '佐藤花子 <foo@example.com>', :subject => '日本語件名') do |format|
	      format.text { render :inline => '日本語本文' }
	    end
	  end
	end


Remarks
-------

* (en)
    * NEC special characters like `①` and IBM extended characters like `髙`, `﨑`
    are allowed in the subject, recipient names and mail body.
    * FULLWIDTH TILDE (U+FF5E) and WAVE DASH (U+301C, `〜`) are converted to the fullwidth tilde (0x2141, `～`).
    * FULLWIDTH HYPHEN MINUS (U+FF0D) and MINUS SIGN (U+2212) are converted to the fullwidth minus (0x215d, `－`).
    * EM DASH (U+2014) and HORIZONTAL BAR (U+2015) are converted to the dash sign (0x213d, `―`).
    * DOUBLE VERTICAL LINE (U+2016, `‖`) and PARALLEL TO (U+2225, `∥`) to the double vertical line (0x2142, `‖`).
    * Halfwidth (Hankaku) katakanas are maintained intact.
    * Characters that cannot be translated into iso-2022-jp encoding are substituted with question marks (`?`).
    * A pull request https://github.com/mikel/mail/pull/534 has been sent to the `mikel/mail` repository but not yet accepted.

* (ja)
    * `①` などのNEC特殊文字や `髙` や `﨑` といったIBM拡張文字を件名、宛先、本文などに含めることができます。
    * 全角チルダ(U+FF5E, `～`)と波ダッシュ(U+301C, `〜`)は、全角チルダ(0x2141, `～`)に変換されます。
    * 全角ハイフンマイナス(U+ff0D)とマイナス記号(U+2212)は、全角マイナス(0x215d, `－`)に変換されます。
    * 長い(em)ダッシュ(U+2014, `—`)と水平線(U+2015, `―`)は、ダッシュ(0x213d, `―`)に変換されます。
    * 二重縦線(U+2016, `‖`)と平行記号(U+2225, `∥`)は、二重縦線(0x2142, `‖`)に変換されます。
    * 半角カタカナはそのまま維持されます。
    * 変換できない文字は疑問符(`?`)で置換されます。
    * `mikel/mail` リポジトリにプルリクエスト https://github.com/mikel/mail/pull/534 が送られていますが、まだアクセプトされていません。

References
----------

* http://d.hatena.ne.jp/fujisan3776/20110628/1309255427
* http://d.hatena.ne.jp/rudeboyjet/20100605/p1
* http://d.hatena.ne.jp/hichiriki/20101026#1288107706
* http://d.hatena.ne.jp/deeeki/20111003/rails3_mailer_iso2022jp
* http://d.hatena.ne.jp/tmtms/20090611/1244724573
* Wikipedia [Unicode - 波ダッシュ・全角チルダ問題](http://ja.wikipedia.org/wiki/Unicode#.E6.B3.A2.E3.83.80.E3.83.83.E3.82.B7.E3.83.A5.E3.83.BB.E5.85.A8.E8.A7.92.E3.83.81.E3.83.AB.E3.83.80.E5.95.8F.E9.A1.8C)

License
-------

(en) `mail-iso-2022-jp` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/kuroda/mail-iso-2022-jp/blob/master/MIT-LICENSE))

(ja) `mail-iso-2022-jp` はMITライセンスで配布されています。 ([MIT-LICENSE](https://github.com/kuroda/mail-iso-2022-jp/blob/master/MIT-LICENSE))


Special thanks
--------------

[Kohei Matsushita](https://github.com/ma2shita) -- Initial creator of this patch.
