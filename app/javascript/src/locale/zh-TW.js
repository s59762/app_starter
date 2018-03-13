I18n.translations || (I18n.translations = {});
I18n.translations["zh-TW"] = I18n.extend((I18n.translations["zh-TW"] || {}), {"aasm_state":{"admin":null,"user":null},"actions":{"admin":{"add_new":"新增%{model}","cancel":"取消","change_password":"變更密碼","close":"關閉","confirm":"確認","confirm_delete":"確定要刪除%{model}嗎？","confirm_to_delete":"確認刪除%{model}","create":"建立%{model}","delete":"刪除","destroy":"刪除%{modle}","detail_of":"%{model}詳細內容","edit":"編輯","edit_on":"編輯%{model}","get_info_for":"查看%{model}","if_do_not_want_to_change_password_leave_empty":"若不變更密碼請留空","index":"%{model}列表","leave_empty_for_default_password":"不設定密碼將會使用預設密碼 `qwerasdf`","login":"登入","logout":"登出","management":"管理%{model}","new":"建立%{model}","open":"開啟","options":"選項","please_re_enter_password_for_confirmation":"請再輸入一次密碼做為確認","preview":"預覽","reply":"回覆","reset_search":"清除條件","save":"儲存","search":"搜尋","search_by":"以%{attribute_name}搜尋","search_for":"搜尋%{model_name}","show":"詳細內容","submit":"送出資料","suspend_admin":"停權","this_action_can_not_retrieve":"這個動作將無法復原","unsuspend_admin":"復權","update_profile":"編輯檔案"}},"activerecord":{"attributes":{"admin":{"avatar":"頭像","confirmation_sent_at":"認證信寄出時間","confirmation_token":"認證 TOKEN","confirmed_at":"認證時間","created_at":"建立時間","current_password":"原始密碼","current_sign_in_at":"現在登入狀態開始於","current_sign_in_ip":"現在登入中的 IP 位址","email":"電子信箱","encrypted_password":"加密後的密碼","failed_attempts":"錯誤嘗試次數","is_suspended":"已停權","last_sign_in_at":"上次登入於","last_sign_in_ip":"上次登入的 IP 位址","locked_at":"封鎖時間","name":"姓名","new_password":"新密碼","password":"密碼","password_confirmation":"確認密碼","remember_created_at":null,"remember_me":"記住我的資訊","reset_password_sent_at":"重置密碼引導信件祭出時間","reset_password_token":"重置密碼 TOKEN","role":"角色","sign_in_count":"登入次數","unconfirmed_email":"未認證 Email","unlock_token":"解除封鎖 TOKEN","updated_at":"更新於"},"user":{"avatar":"頭像","confirmation_sent_at":"認證信寄出時間","confirmation_token":"認證 TOKEN","confirmed_at":"認證時間","created_at":"建立時間","current_password":"原始密碼","current_sign_in_at":"現在登入狀態開始於","current_sign_in_ip":"現在登入中的 IP 位址","email":"電子信箱","encrypted_password":"加密後的密碼","failed_attempts":"錯誤嘗試次數","last_sign_in_at":"上次登入於","last_sign_in_ip":"上次登入的 IP 位址","locked_at":"封鎖時間","name":"姓名","new_password":"新密碼","password":"密碼","password_confirmation":"確認密碼","remember_created_at":null,"remember_me":"記住我的資訊","reset_password_sent_at":"重置密碼引導信件祭出時間","reset_password_token":"重置密碼 TOKEN","sign_in_count":"登入次數","unconfirmed_email":"未認證 Email","unlock_token":"解除封鎖 TOKEN","updated_at":"更新於"}},"errors":{"messages":{"record_invalid":"校驗失敗: %{errors}","restrict_dependent_destroy":{"has_many":"由於 %{record} 需要此記錄，所以無法移除記錄","has_one":"由於 %{record} 需要此記錄，所以無法移除記錄"}},"models":{"admin":{"attributes":{"new_password":{"password_mismatch":"兩次輸入的密碼不相同"},"password":{"password_mismatch":"兩次輸入的密碼不相同"}}},"user":{"attributes":null}}},"models":{"admin":{"one":"管理員","other":"管理員"},"user":{"one":"會員","other":"會員"}}},"admin":{"common":{"admin_root":"管理首頁","administrator":"管理員"}},"date":{"abbr_day_names":["周日","周一","周二","周三","周四","周五","周六"],"abbr_month_names":[null,"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],"day_names":["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],"formats":{"default":"%Y-%m-%d","long":"%Y年%m月%d日","short":"%m月%d日"},"month_names":[null,"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],"order":["year","month","day"]},"datetime":{"distance_in_words":{"about_x_hours":{"one":"大約一小時","other":"大約 %{count} 小時"},"about_x_months":{"one":"大約一個月","other":"大約 %{count} 個月"},"about_x_years":{"one":"大約一年","other":"大約 %{count} 年"},"almost_x_years":{"one":"接近一年","other":"接近 %{count} 年"},"half_a_minute":"半分鐘","less_than_x_minutes":{"one":"不到一分鐘","other":"不到 %{count} 分鐘"},"less_than_x_seconds":{"one":"不到一秒","other":"不到 %{count} 秒"},"over_x_years":{"one":"一年多","other":"%{count} 年多"},"x_days":{"one":"一天","other":"%{count} 天"},"x_minutes":{"one":"一分鐘","other":"%{count} 分鐘"},"x_months":{"one":"一個月","other":"%{count} 個月"},"x_seconds":{"one":"一秒","other":"%{count} 秒"},"x_years":{"one":"一年","other":"%{count} 年"}},"prompts":{"day":"日","hour":"時","minute":"分","month":"月","second":"秒","year":"年"}},"devise":{"confirmations":{"confirmed":"您的帳號已通過驗證，現在您已成功登入。","new":{"resend_confirmation_instructions":"重新寄送確認信"},"send_instructions":"您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。","send_paranoid_instructions":"如果我們有您的信箱，您將會收到一封驗證您的帳號的電子郵件。"},"failure":{"already_authenticated":"您已經登入。","inactive":"您的帳號尚未被啟用。","invalid":"Invalid %{authentication_keys} or password.","last_attempt":"您還有最後一次嘗試機會，再次失敗您的帳號將會被鎖定。","locked":"您的帳號已被鎖定。","not_found_in_database":"Invalid %{authentication_keys} or password.","timeout":"您的登入時效過期，請重新登入。","unauthenticated":"您需要先登入或註冊後才能繼續。","unconfirmed":"您的帳號需要經過驗證後，才能繼續。"},"mailer":{"confirmation_instructions":{"action":"確認帳號","greeting":"%{recipient} 您好!","instruction":"您可以利用下面的連結確認您的帳戶的電子郵件：","subject":"帳號驗證步驟"},"email_changed":{"subject":"Email Changed"},"password_change":{"greeting":"您好 %{recipient}!","message":"它會通知您，您的密碼已被更改。","subject":"密碼已更改"},"reset_password_instructions":{"action":"更改我的密碼","greeting":"您好 %{recipient}!","instruction":"有人要求更改密碼的連結，您可以利用下面的連結更改密碼。","instruction_2":"如果您沒有要求，請忽略此電子郵件。","instruction_3":"如果您沒有進入上面的連結，並建立新的密碼，您的密碼不會被改變。","subject":"密碼重設步驟"},"unlock_instructions":{"action":"帳戶解鎖","greeting":"您好 %{recipient}!","instruction":"點擊下面的連結到您的帳戶進行解鎖：","message":"由於多次不成功的登入嘗試，您的帳戶已被鎖定。","subject":"帳號解鎖步驟"}},"omniauth_callbacks":{"failure":"無法從 %{kind} 驗證，因為 \"%{reason}\"。","success":"成功從 %{kind} 驗證。"},"passwords":{"edit":{"change_my_password":"更改我的密碼","change_your_password":"更改您的密碼","confirm_new_password":"確認新密碼","new_password":"新密碼"},"new":{"forgot_your_password":"忘記密碼？","send_me_reset_password_instructions":"請寄重設密碼的說明信件給我"},"no_token":"這是密碼重設頁面，僅能透過密碼重設信件進入。如果您是透過重設信件進入的，請確認您的網址是完整的。","send_instructions":"您將在幾分鐘後收到一封電子郵件，內有重新設定密碼的步驟說明。","send_paranoid_instructions":"如果我們有您的信箱，您將會收到一封內含可重新設定密碼連結的電子郵件。","updated":"您的密碼已被修改，您現在已經登入。","updated_not_active":"您的密碼已被修改。"},"registrations":{"destroyed":"再會！您的帳號已被取消。有緣再會。","edit":{"are_you_sure":"您確定嗎？","cancel_my_account":"取消我的帳戶","currently_waiting_confirmation_for_email":"等待 %{email} 的確認","leave_blank_if_you_don_t_want_to_change_it":"不想修改的話就不需要填寫這個欄位","title":"修改 %{resource}","unhappy":"不喜歡","update":"更新","we_need_your_current_password_to_confirm_your_changes":"我們需要您的目前的密碼以確認您的更改"},"new":{"sign_up":"註冊"},"signed_up":"註冊成功，歡迎！","signed_up_but_inactive":"您已註冊成功。然而因為您的帳號尚未啓動，暫時無法登入，抱歉！","signed_up_but_locked":"您已註冊成功。 然而因為您的帳號已被鎖定，暫時無法登入，抱歉！","signed_up_but_unconfirmed":"確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。","update_needs_confirmation":"您已經成功的更新帳號資訊，但我們仍需確認您的電子信箱，請至新信箱收信並點擊連結以確認您的新電子郵件帳號。","updated":"您已經成功的更新帳號資訊。"},"sessions":{"already_signed_out":"成功登出了。","new":{"sign_in":"登入"},"signed_in":"成功登入了。","signed_out":"成功登出了。"},"shared":{"links":{"back":"返回","didn_t_receive_confirmation_instructions":"沒有收到確認信件？","didn_t_receive_unlock_instructions":"沒有收到解鎖信件？","forgot_your_password":"忘記密碼？","sign_in":"登入","sign_in_with_provider":"用 %{provider} 登入","sign_up":"註冊"}},"unlocks":{"new":{"resend_unlock_instructions":"重發解鎖說明信件"},"send_instructions":"您將在幾分鐘後收到一封電子郵件，內有將帳號解除鎖定的步驟說明。","send_paranoid_instructions":"如果您的帳號已存在，您的電子信箱將會收到如何解鎖帳號的指示。","unlocked":"您的帳號已被解鎖，現在已經登入。"}},"enums":{"admin":{"role":{"accounter":"會計帳號","content_manager":"內容管理員","not_signed_in":"無權限","owner":"網站擁有者","stock_manager":"庫存管理員","super":"高級管理員"}},"user":null},"helpers":{"page_entries_info":{"entry":{"one":"entry","other":"entries","zero":"entries"},"more_pages":{"display_entries":"顯示 \u003cb\u003e%{total}\u003c/b\u003e 筆 %{entry_name} 中的第 \u003cb\u003e%{first}\u0026nbsp;-\u0026nbsp;%{last}\u003c/b\u003e 筆"},"one_page":{"display_entries":{"one":"顯示 \u003cb\u003e1\u003c/b\u003e 筆 %{entry_name}","other":"顯示 \u003cb\u003e全部 %{count}\u003c/b\u003e 筆 %{entry_name}","zero":"沒有任何 %{entry_name}"}}},"select":{"prompt":"請選擇"},"submit":{"create":"新增%{model}","submit":"儲存%{model}","update":"更新%{model}"}},"messages":{"admin_added_succefully":"已新增管理員","admin_is_suspended":"管理員 %{name} 已停權","admin_is_unsuspended":"管理員 %{name} 已復權","admin_updated_succefully":"管理員資料已更新","error":{"jwt_token_been_modified":"您的身份憑證可能遭到竄改，請重新登入取得正確的憑證。"},"failure":{"parameters_failure":"您提供的參數不符合規範","policy_validate_failure":"您的帳號並不能執行這個動作","token_authenticate_failure":"身份認證失敗，請嘗試重新登入","validation_failure":"請您檢查表單後再試一次"},"server_side_500_error":"抱歉，伺服器發生問題，請稍後再試"},"number":{"currency":{"format":{"delimiter":",","format":"%u %n","precision":2,"separator":".","significant":false,"strip_insignificant_zeros":false,"unit":"NT$"}},"format":{"delimiter":",","precision":3,"separator":".","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":"十億","million":"百萬","quadrillion":"千兆","thousand":"千","trillion":"兆","unit":""}},"format":{"delimiter":"","precision":1,"significant":false,"strip_insignificant_zeros":false},"storage_units":{"format":"%n %u","units":{"byte":{"one":"位元組","other":"位元組"},"eb":"EB","gb":"GB","kb":"KB","mb":"MB","pb":"PB","tb":"TB"}}},"percentage":{"format":{"delimiter":"","format":"%n%"}},"precision":{"format":{"delimiter":""}}},"page_titles":{"admin":{"admins":{"edit":"編輯管理員","index":"列表","main_title":"人員管理","new":"新增管理員","show":"詳細資料"},"dashboard":{"main_title":"資訊面板","show":"網站狀態簡報"},"login":{"subtitle":"本頁面僅限 Admin 帳號使用","title":"請先登入"},"profile":{"main_title":"管理員個人檔案","show":"編輯"},"users":{"edit":"編輯會員","index":"列表","main_title":"會員管理","show":"詳細資料"}},"user":{"login":{"subtitle":"我們需要確認您的身份以提供個人化服務","title":"請先登入"},"profile":{"main_title":"管理個人資料"}}},"support":{"array":{"last_word_connector":", 和 ","two_words_connector":" 和 ","words_connector":", "}},"time":{"am":"上午","formats":{"default":"%Y年%m月%d日 %A %H:%M:%S %Z","long":"%Y年%m月%d日 %H:%M","pm":"下午","short":"%m月%d日 %H:%M","us":"%m/%d/%Y %I:%M %p"},"pm":"PM"},"views":{"pagination":{"first":"\u0026laquo;","last":"\u0026raquo;","next":"\u0026rsaquo;","previous":"\u0026lsaquo;","truncate":"\u0026hellip;"}}});
