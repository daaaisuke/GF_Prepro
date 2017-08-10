class Image::RegisterController < ApplicationController

  # *** トップページ ***
  def index
    tmp = TmpImage.first
    @image = tmp[:filename]
    @blocks = TextBlock.view_css(tmp[:image_id])
  end


  # *** ラベル登録用のメソッド ***
  def register
    pos = params[:pos]
    text = TextBlock.create(
      image_id: TmpImage.first[:image_id],
      text: pos[:text],
      x1: pos[:pos1_x1],  y1: pos[:pos1_y1],
      x2: pos[:pos2_x2],  y2: pos[:pos2_y2]
    )
    redirect_to root_path
  end


  # *** 前の操作を取り消すメソッド ***
  def delete
    TextBlock.last.delete
    redirect_to root_path
  end


  # *** 次の画像に移動するメソッド ***
  def next
    # 現状の画像を完了に
    tmp = TmpImage.first
    image = Image.find_by(filename: tmp[:filename])
    image.update(is_complete: true)
    # 新しい画像に切り替える
    files = Dir::entries("app/assets/images/")
    files.each do |file|
      next unless %w(.jpg .png .jpeg).include?(File.extname(file))
      # ファイル名が既に書き込まれていないか確認
      db_files = Image.where(filename: file)
      if db_files.empty?
        image = Image.create(filename: file)
        TmpImage.first.update(filename: file, image_id: image.id)
        break
      end
    end
    # トップページへ遷移
    redirect_to root_path
  end


  # *** ダウンロードページ ***
  def download
    respond_to do |format|
      format.html
      format.csv do
        filename = 'recognition_result'
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      end
    end
  end


  # *** リセット（初期化）用のページ ***
  def reset
    # データベースの中身を削除する
    Image.delete_all
    TmpImage.delete_all
    TextBlock.delete_all
    # 最初の画像を指定する ※ サンプル画像以外の場合はこちらを書き換え
    image = Image.create(filename:"test1.jpeg")
    TmpImage.create(filename:image[:filename], image_id: image.id)
    redirect_to root_path
  end

end
