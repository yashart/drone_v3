import QtQuick 2.4

LoginPageForm {
    id: loginPage
    loginButton.onClicked: {
        if ((passwordTextField.text == "admin")&&
            (loginTextField.text == "admin")){
            loginPage.visible = false
            mainPage.visible = true
            mainPage.leftTabMenu.visible = true
        }
    }
    Keys.onPressed: {
        if (event.key == 16777220){
            if ((passwordTextField.text == "admin")&&
                (loginTextField.text == "admin")){
                loginPage.visible = false
                mainPage.visible = true
                mainPage.leftTabMenu.visible = true
            }
        }
    }
}
