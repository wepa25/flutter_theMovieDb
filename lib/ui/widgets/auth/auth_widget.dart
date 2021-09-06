import 'package:flutter/material.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/styles/styles_of_app_widget.dart';
import 'package:the_movie/ui/widgets/auth/auth_model.dart';

class AuthWidget extends StatelessWidget {
  AuthWidget({Key? key}) : super(key: key);

  final iconButtons = [
    IconButton(
        iconSize: 22,
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(Icons.account_circle_rounded)),
    IconButton(
        iconSize: 22,
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(Icons.search)),
  ];
  final textButton = TextButton(
    onPressed: () {},
    child: Text(
      'Нажмите здесь',
      style: TextStyle(color: Colors.blue),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StylesOFAppWidget.colorOfAppBar,
        centerTitle: true,
        elevation: 10,
        title: Text(
          'The Movie DB ',
          style: TextStyle(color: Colors.blue[200]),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: iconButtons,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 20,),
                Text(
                  'Войти в свою учётную запись',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Чтобы пользоваться правкой и возможностями рейтинга TMDb,'
                  ' а также получить персональные рекомендации, необходимо'
                  ' войти в свою учётную запись. Если у вас нет учётной записи,'
                  ' её регистрация является бесплатной и простой.',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text('Чтобы начать'),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Нажмите здесь',
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 10,),
                Text(
                  'Если Вы зарегистрировались, но не получили письмо для подтверждения',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text('Чтобы отправить письмо еще'),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Нажмите здесь',
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                ErrorMessageWidget(),
                Text(
                  'Имя пользователя',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                TextField(
                  enableInteractiveSelection: true,
                  controller: model?.controllerLogin,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 15),
                Text(
                  'Пароль',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                TextField(
                  enableInteractiveSelection: true,
                  obscureText: true,
                  controller: model?.controllerPassword,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const AuthButtonWidget(),
                    SizedBox(
                      width: 25,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Сбросить пароль'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: StylesOFAppWidget.colorOfAppBar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.blue[900])),
                      onPressed: () {},
                      child: Text(
                        'ВСТУПИТЬ В СООБЩЕСТВО',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final child = model?.isAuthProgress == true
        ? SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2,))
        : Text(
            'Войти',
            style: TextStyle(fontWeight: FontWeight.bold),
          );
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
