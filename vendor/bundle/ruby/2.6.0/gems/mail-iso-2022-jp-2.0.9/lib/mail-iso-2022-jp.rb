require 'mail-iso-2022-jp/character_names'
require 'mail-iso-2022-jp/invalid_encoding_error'
require 'mail-iso-2022-jp/common_methods_for_field'
require 'mail-iso-2022-jp/preprocessor'

if RUBY_VERSION >= '1.9'
  require 'mail-iso-2022-jp/mail'
  require 'mail-iso-2022-jp/message'
  require 'mail-iso-2022-jp/field'
  require 'mail-iso-2022-jp/field_with_iso_2022_jp_encoding'
  require 'mail-iso-2022-jp/body'
else
  require 'mail-iso-2022-jp/ruby18/mail'
  require 'mail-iso-2022-jp/ruby18/message'
  require 'mail-iso-2022-jp/ruby18/field_with_iso_2022_jp_encoding'
end

require 'mail-iso-2022-jp/header'
require 'mail-iso-2022-jp/subject_field'
require 'mail-iso-2022-jp/structured_fields'
