class AddUserToComments < ActiveRecord::Migration[8.0]
  def up
    add_reference :comments, :user, null: true, foreign_key: true

    user = User.first || User.create!(
      email: "system@example.com",
      password: SecureRandom.hex(16),
      password_confirmation: nil
    )

    Comment.where(user_id: nil).update_all(user_id: user.id)

    change_column_null :comments, :user_id, false
  end

  def down
    remove_reference :comments, :user, foreign_key: true
  end
end