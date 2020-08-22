# README

勝手にリファクタリングしてみました。  
リファクタリングしたアプリは、Ryoさんが作成したTodoAppです。  

**GitHub**  
https://github.com/ryo27-jp/Todoapp  

**heroku**  
https://morning-sierra-80148.herokuapp.com  

## 変更点

[変更内容はcommitログから](https://github.com/miketa-webprgr/RefactoringPractice-TodoApp/commit/76c2ee383b393b3f8653a669c42c2f24e69f370b)  
（ただし、変更内容を全てまとめてcommitしているため、非常に見辛いです）  

### `users_controller.rb`と`viewers_controller.rb`の大幅なリファクタリング

`users_controller`について、勘違いしていなければ、newとcreateアクション以外は、  
あくまでeditor_user（親）がviewer_user（子）を作る時にしか使っていなかったので、  
思い切って、`viewers_controller.rb`に移行しました。（そちらの方が自然な気がしたので）  

これがなかなか大変でした笑  
もしかしたら、若干強引な部分があったかもしれません。  

### `viewer_user`か`editor_user`か意識しなくてよいように独自メソッドを作成した

```rb
# application_controller.rb
  def set_editor
    viewer_user ? viewer_user.editor : editor_user
  end
```

### `set_my_todos`と`set_selected_todo`という独自メソッドを作成した

好き嫌いはあると思いますが、これを使うことで、各アクションに重複しているコードが  
分かりやすく、シンプルに書けるようになるかと思います。。。  

```rb
# todos_controller.rb

  # 関係するcategoriesをsetする独自メソッドを作成
  def set_my_todos
    set_editor.todos
  end

  # 関係するtodosの中で、該当のtodoをsetする独自メソッドを作成
  def set_selected_todo
    @todo = set_my_todos.find(params[:id])
  end
```

### `set_my_todos`と`set_selected_todo`という独自メソッドを作成した

やっていることは、`todos_controller.rb`と全く同じです。  

```rb
# categories_controller.rb
  # 関係するcategoriesをsetする独自メソッドを作成
  def set_my_categiories
    set_editor.categories
  end

  # 関係するcategoriesの中で、該当のcategoryをsetする独自メソッドを作成
  def set_selected_category
    @category = set_editor.categories.find(params[:id])
  end
```

### `set_selected_viewer`という独自メソッドを作成した

やっていることは、`todos_controller.rb`とほぼ同じです。  
ただ、このコントローラは`editor_user`しか使わわないため、`set_my_viewers`メソッドを  
作成する必要性がありません。なので、`set_selected_viewer`しか作っていません。  

```rb
# viewers_controller.rb
  # 関係するviewersの中で、該当のviewerをsetする独自メソッドを作成
  def set_selected_viewer
    @viewer = editor_user.viewers.find(params[:id])
  end
```

### log_inメソッドをコントローラに寄せた

書いているとおりです。  
また、session_controllers内で、log_inメソッドに置き換えられるところを置き換えました。  
