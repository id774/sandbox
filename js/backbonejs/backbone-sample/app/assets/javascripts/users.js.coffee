# users.js.coffee: Backbone model, collection, and view for users
#
# Description:
# Define the User model, the UserStore collection bound to /users, and the
# view that creates and removes users through REST calls to UsersController.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

class User extends Backbone.Model
    id: null
    name: null

class UserStore extends Backbone.Collection
    model: User
    url: '/users'

class UserView extends Backbone.View
    el: $("body")
    events:
        'click #add-user'    : 'createUser'
        'click .remove-user' : 'removeUser'

    initialize: () ->
        @users = new UserStore
        @list()
        @users.bind("add", @render, @)

    createUser: (data) ->
        user_name = $('#user_name').val()
        $('#user_name').val ''
        @users.create  name: user_name

    removeUser: (e) ->
        user = @users.get(e.currentTarget.id).destroy
            success: (model, response) =>
                $("#list").empty()
                @list()

    list: ->
        @users.fetch
            success: (model, response) =>
                $.each response, (key, val) =>
                    @render(new User({ id: val.id, name: val.name }))

    render: (user) ->
        $("#list").append("<li>" + user.get('name') + "<button class=\"remove-user\" id=\"" + user.get('id') + "\">Remove User</button></li>")


user_view = new UserView
