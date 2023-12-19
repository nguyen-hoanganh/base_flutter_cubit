part of '../login_screen.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({
    super.key,
    required this.isUsername,
    required this.callBack,
    required this.biometricType,
  });
  final bool isUsername;
  final List<BiometricType> biometricType;
  final Function()? callBack;

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  late final _cubit = context.read<LandingCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingCubit, LandingState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 24.s, right: 24.s),
          child: Column(
            children: [
              //text hello cbp
              Text(
                AppLocalizations.current.heloCbp.toUpperCase(),
                style: CommonTextStyle.bodyB2.copyWith(fontSize: 24.s),
              ),
              Gap(widget.isUsername ? 7.5.s : 0),
              widget.isUsername
                  ? Text(
                      AppLocalizations.current.welcome,
                      style: CommonTextStyle.bodyB2,
                    )
                  : const Text(''),
              Gap(widget.isUsername ? 74.35.s : 104.s),
              widget.isUsername ? userLoaded() : inputUserID(state),
              Gap(16.s),
              buildButtonLogin(state),
            ],
          ),
        );
      },
    );
  }

  //USER LOGIN RETURNING
  Widget userLoaded() {
    Widget iconBiometric = Assets.svgs.faceId.svg();
    if (widget.biometricType.contains(BiometricType.fingerprint)) {
      iconBiometric = Assets.svgs.fingerPrint.svg();
    }
    return Row(
      children: [
        Text(
          AppManager.shared.username.maskedString,
          style: CommonTextStyle.bodyB4,
        ),
        const Spacer(),
        GestureDetector(
          onTap: widget.callBack,
          child: iconBiometric,
        ),
      ],
    );
  }

// USER LOGIN FIRST TIME
  Widget inputUserID(LandingState state) {
    return NormalInput(
      configs: NormalInputConfigs(
        controller: _textController,
        prefixIcon: Assets.svgs.icPeople.svg(),
        labelText: AppLocalizations.current.userId,
        labelTextStyle:
            CommonTextStyle.bodyB4.copyWith(color: CommonColors.neutralColor3),
        textStyle: CommonTextStyle.supportFontSubtitle1
            .copyWith(color: CommonColors.neutralColor2),
        boxBorder: Border.all(color: CommonColors.neutralColor6),
        floatingLabelTextStyle:
            CommonTextStyle.bodyB2.copyWith(color: CommonColors.neutralColor3),
        focusNode: _nameFocusNode,
        errorText: state.errorUsername,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
        ],
        onChanged: (value) {
          trimSpaceText(value, _textController);
          _cubit.checkDisabledButton(value);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

// BUTTON LOGIN
  Widget buildButtonLogin(LandingState state) {
    return Button(
      configs: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.primary,
        disabled: !widget.isUsername && !state.isDisableButton ? true : false,
        content: AppLocalizations.current.logIn,
        padding: EdgeInsets.symmetric(vertical: 12.s),
        onTap: () async {
          if (widget.isUsername) {
            //todo something
          } else {
            //todo something
          }
        },
        contentStyle:
            CommonTextStyle.bodyB2.copyWith(color: CommonColors.neutralColor7),
      ),
    );
  }
}
