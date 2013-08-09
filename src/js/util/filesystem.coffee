

window.requestFileSystem = window.requestFileSystem || window.webkitRequestFileSystem

successCallback = (fs) ->
  reader = do fs.root.createReader
  entries = []
  readEntries = ->
    reader.readEntries ((results)->
      if not results.length
        console.log  entries
      else
        entries = entries.concat(toArray(results))
        do readEntries

      ), onError

  do readEntries

onError = (event) ->
  console.log event

errorHandler: (e)->
  msg = ''
  switch e.code
    when FileError.QUOTA_EXCEEDED_ERR
      msg = 'QUOTA_EXCEEDED_ERR'
    when FileError.NOT_FOUND_ERR
      msg = 'NOT_FOUND_ERR'
    when FileError.SECURITY_ERR
      msg = 'SECURITY_ERR'
    when FileError.INVALID_MODIFICATION_ERR
      msg = 'INVALID_MODIFICATION_ERR'
    when FileError.INVALID_STATE_ERR
      msg = 'INVALID_STATE_ERR'
    else
      msg = 'Unknown Error'

  alert msg


window.requestFileSystem window.PERSISTENT, 24*1024*1024, successCallback, onError