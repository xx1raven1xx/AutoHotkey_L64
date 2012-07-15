; 行内の「;」以降はコメントになります。
; プラグインの追加方法
; 1行に一個のプラグインを記述できます。
; まず行の最初に「#include 」と打つ（最後の スペース を忘れずに）
; 次に読み込ませたいプラグインを作業ディレクトリからの相対パスまたは絶対パスで記述
; 基本的にAutoBase内のPluginフォルダに入れるのを推奨するため、
; 「#include Plugin\{プラグインファイル名}」という記述になる。
; ※{プラグインフォルダ名}は読み込ませたいプラグインのファイル名に変えてください。

;#include Plugin\PluginTemplete.ahk
;#include Plugin\PluginTemplete2.ahk
;#include Plugin\TestMenuPlugin.ahk
#include Plugin\AutoBase_TestPluginClass.ahk