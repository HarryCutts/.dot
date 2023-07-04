# Provides a utility method for sending messages to a Google Chat room via a
# webhook. To set this up, follow the instructions in the Google Developer docs
# [0] and put the URL in ~/.config/elvish/gchat-webhook-url.
#
# [0]: https://developers.google.com/chat/how-tos/webhooks

var configured = $false

var -webhook-url-file-path = ~/.config/elvish/gchat-webhook-url
if ?(var -webhook-url = (cat $-webhook-url-file-path stderr>/dev/null)) {
  set configured = $true
}

fn send {|message|
  if (not $configured) { fail "Google Chat webhook not configured." }
  var post-data = (put [&text=$message] | to-json)
  wget --quiet --output-document=/dev/null ^
       --header='Content-Type: application/json; charset=UTF-8' ^
       --post-data=$post-data $-webhook-url
}
