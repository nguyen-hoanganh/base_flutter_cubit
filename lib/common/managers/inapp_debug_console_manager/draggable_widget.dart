import 'dart:math';

import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/draggable_widget/anchoringposition.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/draggable_widget/pin_position.dart';
import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;

  final double horizontalSpace;

  final double verticalSpace;

  final AnchoringPosition initialPosition;

  final PinPosition? pinPosition;

  final bool intialVisibility;

  final double bottomMargin;

  final double topMargin;

  final double statusBarHeight;

  final double shadowBorderRadius;

  final DragController dragController;

  final BoxShadow normalShadow;

  final BoxShadow draggingShadow;

  final double dragAnimationScale;

  final Duration touchDelay;

  final Function()? onTap;

  const DraggableWidget({
    Key? key,
    required this.child,
    required this.dragController,
    this.pinPosition,
    this.horizontalSpace = 0,
    this.verticalSpace = 0,
    this.initialPosition = AnchoringPosition.bottomRight,
    this.intialVisibility = true,
    this.bottomMargin = 0,
    this.topMargin = 0,
    this.statusBarHeight = 24,
    this.shadowBorderRadius = 10,
    this.dragAnimationScale = 1.1,
    this.touchDelay = Duration.zero,
    this.normalShadow = const BoxShadow(
      color: Colors.black38,
      offset: Offset(0, 4),
      blurRadius: 2,
    ),
    this.draggingShadow = const BoxShadow(
      color: Colors.black38,
      offset: Offset(0, 10),
      blurRadius: 10,
    ),
    this.onTap,
  })  : assert(statusBarHeight >= 0),
        assert(horizontalSpace >= 0),
        assert(verticalSpace >= 0),
        assert(bottomMargin >= 0),
        super(key: key);

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget>
    with SingleTickerProviderStateMixin {
  double top = 0, left = 0;
  double boundary = 0;
  late AnimationController animationController;
  late Animation animation;
  double hardLeft = 0, hardTop = 0;
  bool offstage = true;
  AnchoringPosition? currentDocker;
  Offset? lastUpOffset;

  double widgetHeight = 18;
  double widgetWidth = 50;

  final key = GlobalKey();

  bool dragging = false;

  late AnchoringPosition currentlyDocked;

  bool? visible;

  bool get currentVisibilty => visible ?? widget.intialVisibility;

  bool isStillTouching = false;

  @override
  void initState() {
    currentlyDocked = widget.initialPosition;
    hardTop = widget.topMargin;
    animationController = AnimationController(
      value: 1,
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )
      ..addListener(() {
        if (currentDocker != null) {
          animateWidget(currentDocker);
        }
      })
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            hardLeft = left;
            hardTop = top;
          }
        },
      );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    widget.dragController._addState(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final widgetSize = getWidgetSize(key);
      if (widgetSize != null) {
        setState(() {
          widgetHeight = widgetSize.height;
          widgetWidth = widgetSize.width;
        });
      }

      await Future.delayed(const Duration(milliseconds: 100));

      setState(() {
        offstage = false;
        boundary = MediaQuery.of(context).size.height - widget.bottomMargin;
        if (widget.initialPosition == AnchoringPosition.bottomRight) {
          top = boundary - widgetHeight + widget.statusBarHeight;
          left = MediaQuery.of(context).size.width - widgetWidth;
        } else if (widget.initialPosition == AnchoringPosition.bottomLeft) {
          top = boundary - widgetHeight + widget.statusBarHeight;
          left = 0;
        } else if (widget.initialPosition == AnchoringPosition.topRight) {
          top = widget.topMargin;
          left = MediaQuery.of(context).size.width - widgetWidth;
        } else {
          top = widget.topMargin;
          left = 0;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DraggableWidget oldWidget) {
    if (!offstage) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final widgetSize = getWidgetSize(key);
        if (widgetSize != null) {
          setState(() {
            widgetHeight = widgetSize.height;
            widgetWidth = widgetSize.width;
          });
        }
        setState(() {
          boundary = MediaQuery.of(context).size.height - widget.bottomMargin;
          animateWidget(currentlyDocked);
        });
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: !currentVisibilty
            ? Container()
            : Listener(
                onPointerUp: (v) {
                  if (!isStillTouching) {
                    return;
                  }
                  isStillTouching = false;

                  final p = v.position;
                  currentDocker = determineDocker(p.dx, p.dy);
                  if (dragging) lastUpOffset = p;

                  setState(() {
                    dragging = false;
                  });
                  if (animationController.isAnimating) {
                    animationController.stop();
                  }
                  animationController.reset();
                  animationController.forward();
                },
                onPointerDown: (v) async {
                  isStillTouching = false;
                  await Future.delayed(widget.touchDelay);
                  isStillTouching = true;
                },
                onPointerMove: (v) async {
                  if (!isStillTouching) {
                    return;
                  }
                  if (animationController.isAnimating) {
                    animationController.stop();
                    animationController.reset();
                  }

                  setState(() {
                    dragging = true;
                    // if (v.position.dy < boundary &&
                    //     v.position.dy > widget.topMargin) {
                    if (v.position.dy > widget.topMargin) {
                      top = max(v.position.dy - (widgetHeight) / 2, 0);
                    }

                    left = max(v.position.dx - (widgetWidth) / 2, 0);

                    hardLeft = left;
                    hardTop = top;
                  });
                },
                child: Offstage(
                  offstage: offstage,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.onTap,
                    child: Container(
                      key: key,
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.horizontalSpace,
                        vertical: widget.verticalSpace,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(widget.shadowBorderRadius),
                          boxShadow: [
                            dragging
                                ? widget.draggingShadow
                                : widget.normalShadow
                          ],
                        ),
                        child: Transform.scale(
                          scale: dragging ? widget.dragAnimationScale : 1,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  AnchoringPosition determineDocker(double x, double y) {
    final double totalHeight = boundary;
    final double totalWidth = MediaQuery.of(context).size.width;

    AnchoringPosition result;

    if (x <= totalWidth / 2 && y <= totalHeight / 2) {
      result = AnchoringPosition.topLeft;
    } else if (x < totalWidth / 2 && y > totalHeight / 2) {
      result = AnchoringPosition.bottomLeft;
    } else if (x > totalWidth / 2 && y < totalHeight / 2) {
      result = AnchoringPosition.topRight;
    } else {
      result = AnchoringPosition.bottomRight;
    }

    if (widget.pinPosition != null) {
      if (widget.pinPosition == PinPosition.left) {
        if (result == AnchoringPosition.topRight) {
          result = AnchoringPosition.topLeft;
        } else if (result == AnchoringPosition.bottomRight) {
          result = AnchoringPosition.bottomLeft;
        }
      } else {
        if (result == AnchoringPosition.topLeft) {
          result = AnchoringPosition.topRight;
        } else if (result == AnchoringPosition.bottomLeft) {
          result = AnchoringPosition.bottomRight;
        }
      }
    }

    return result;
  }

  void animateWidget(AnchoringPosition? docker) {
    final double totalHeight = boundary;
    final double totalWidth = MediaQuery.of(context).size.width;

    switch (docker) {
      case AnchoringPosition.topLeft:
        setState(() {
          left = (1 - animation.value) * hardLeft;
          // ignore: prefer-conditional-expressions
          if (lastUpOffset != null) {
            top = lastUpOffset!.dy < widget.topMargin
                ? widget.topMargin
                : lastUpOffset!.dy;
          } else {
            top = animation.value == 0
                ? hardTop
                : ((1 - animation.value) * hardTop +
                    (widget.topMargin * (animation.value)));
          }

          currentlyDocked = AnchoringPosition.topLeft;
        });
        break;
      case AnchoringPosition.topRight:
        double remaingDistanceX = (totalWidth - widgetWidth - hardLeft);
        setState(() {
          left = hardLeft + (animation.value) * remaingDistanceX;
          // ignore: prefer-conditional-expressions
          if (lastUpOffset != null) {
            top = lastUpOffset!.dy < widget.topMargin
                ? widget.topMargin
                : lastUpOffset!.dy;
          } else {
            top = animation.value == 0
                ? hardTop
                : ((1 - animation.value) * hardTop +
                    (widget.topMargin * (animation.value)));
          }

          currentlyDocked = AnchoringPosition.topRight;
        });
        break;
      case AnchoringPosition.bottomLeft:
        double remaingDistanceY = (totalHeight - widgetHeight - hardTop);
        setState(() {
          left = (1 - animation.value) * hardLeft;
          // ignore: prefer-conditional-expressions
          if (lastUpOffset != null) {
            top =
                lastUpOffset!.dy > totalHeight ? totalHeight : lastUpOffset!.dy;
          } else {
            top = hardTop +
                (animation.value) * remaingDistanceY +
                (widget.statusBarHeight * animation.value);
          }

          currentlyDocked = AnchoringPosition.bottomLeft;
        });
        break;
      case AnchoringPosition.bottomRight:
        double remaingDistanceX = (totalWidth - widgetWidth - hardLeft);
        double remaingDistanceY = (totalHeight - widgetHeight - hardTop);
        setState(() {
          left = hardLeft + (animation.value) * remaingDistanceX;
          // ignore: prefer-conditional-expressions
          if (lastUpOffset != null) {
            top =
                lastUpOffset!.dy > totalHeight ? totalHeight : lastUpOffset!.dy;
          } else {
            top = hardTop +
                (animation.value) * remaingDistanceY +
                (widget.statusBarHeight * animation.value);
          }

          currentlyDocked = AnchoringPosition.bottomRight;
        });
        break;
      case AnchoringPosition.center:
        double remaingDistanceX =
            (totalWidth / 2 - (widgetWidth / 2)) - hardLeft;
        double remaingDistanceY =
            (totalHeight / 2 - (widgetHeight / 2)) - hardTop;
        setState(() {
          left = (animation.value) * remaingDistanceX + hardLeft;
          top = (animation.value) * remaingDistanceY + hardTop;
          currentlyDocked = AnchoringPosition.center;
        });
        break;
      default:
    }
  }

  Size? getWidgetSize(GlobalKey key) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;

      return box.size;
    } else {
      return null;
    }
  }

  void _showWidget() {
    setState(() {
      visible = true;
    });
  }

  void _hideWidget() {
    setState(() {
      visible = false;
    });
  }

  void _animateTo(AnchoringPosition anchoringPosition) {
    if (animationController.isAnimating) {
      animationController.stop();
    }
    animationController.reset();
    currentDocker = anchoringPosition;
    animationController.forward();
  }

  Offset _getCurrentPosition() {
    return Offset(left, top);
  }
}

class DragController {
  late _DraggableWidgetState _widgetState;

  void _addState(_DraggableWidgetState widgetState) {
    _widgetState = widgetState;
  }

  void jumpTo(AnchoringPosition anchoringPosition) {
    _widgetState._animateTo(anchoringPosition);
  }

  Offset getCurrentPosition() {
    return _widgetState._getCurrentPosition();
  }

  void showWidget() {
    _widgetState._showWidget();
  }

  void hideWidget() {
    _widgetState._hideWidget();
  }
}
