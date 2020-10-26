require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    posts = ["test1", "test2", "test3", "test4", "test5"]
    posts.each do |post|
      fill_in 'message_content', with: post
    end

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect{
      click_on("チャットを終了する")
    }.to change { @room_user.room.message.count }.by(-5)
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path

  end
end
