require_relative "./user_account"

class UserAccountRepository
    def all
        sql = "SELECT id, email_address, username FROM user_accounts;"
        result_set = DatabaseConnection.exec_params(sql, [])

        account_list = []

        result_set.each do |record|
            user = UserAccount.new
            user.id = record["id"].to_i
            user.email_address = record["email_address"]
            user.username = record["username"]

            account_list << user
        end

        # puts account_list[0].email_address
        return account_list
    end

    def find(id)
        sql = "SELECT id, email_address, username FROM user_accounts WHERE id = $1;"
        sql_params = [id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)

        record = result_set[0]
        # ask coaches about this ^

        user = UserAccount.new
        user.id = record["id"].to_i
        user.email_address = record["email_address"]
        user.username = record["username"]

        return user
    end

    def create(user_account)
        sql = 'INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);'
        sql_params = [user_account.email_address, user_account.username]
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM user_accounts WHERE id = $1;'
        sql_params = [id]
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def update(user_account)
        sql = 'UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;'
        sql_params = [user_account.email_address, user_account.username, user_account.id]
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end
end