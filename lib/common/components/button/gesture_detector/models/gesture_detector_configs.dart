import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorConfigs {
  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Secondary widget used for GestureDetectorSwitcher
  final Widget? secondaryChild;

  /// A pointer that might cause a tap has contacted the screen at a particular
  /// location.
  ///
  /// This is called after a short timeout, even if the winning gesture has not
  /// yet been selected. If the tap gesture wins, [onTapUp] will be called,
  /// otherwise [onTapCancel] will be called.
  final GestureTapDownCallback? onTapDown;

  /// Disable press button
  final bool disabled;

  /// A pointer that will trigger a tap has stopped contacting the screen at a
  /// particular location.
  ///
  /// This triggers immediately before [onTap] in the case of the tap gesture
  /// winning. If the tap gesture did not win, [onTapCancel] is called instead.
  final GestureTapUpCallback? onTapUp;

  /// A tap has occurred.
  ///
  /// This triggers when the tap gesture wins. If the tap gesture did not win,
  /// [onTapCancel] is called instead.
  ///
  /// See also:
  ///
  ///  * [onTapUp], which is called at the same time but includes details
  ///    regarding the pointer position.
  final GestureTapCallback? onTap;

  /// The pointer that previously triggered [onTapDown] will not end up causing
  /// a tap.
  ///
  /// This is called after [onTapDown], and instead of [onTapUp] and [onTap], if
  /// the tap gesture did not win.
  final GestureTapCancelCallback? onTapCancel;

  /// The user has tapped the screen at the same location twice in quick
  /// succession.
  final GestureTapCallback? onDoubleTap;

  /// Called when a long press gesture has been recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// See also:
  ///
  ///  * [onLongPressStart], which has the same timing but has data for the
  ///    press location.
  final GestureLongPressCallback? onLongPress;

  final GestureLongPressDownCallback? onLongPressDown;

  /// Callback for long press start with gesture location.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// See also:
  ///
  ///  * [onLongPress], which has the same timing but without the location data.
  final GestureLongPressStartCallback? onLongPressStart;

  /// A pointer has been drag-moved after a long press.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// A pointer that has triggered a long-press has stopped contacting the screen.
  ///
  /// See also:
  ///
  ///  * [onLongPressEnd], which has the same timing but has data for the up
  ///    gesture location.
  final GestureLongPressUpCallback? onLongPressUp;

  /// A pointer that has triggered a long-press has stopped contacting the screen.
  ///
  /// See also:
  ///
  ///  * [onLongPressUp], which has the same timing but without the location data.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// A pointer has contacted the screen and might begin to move vertically.
  final GestureDragDownCallback? onVerticalDragDown;

  /// A pointer has contacted the screen and has begun to move vertically.
  final GestureDragStartCallback? onVerticalDragStart;

  /// A pointer that is in contact with the screen and moving vertically has
  /// moved in the vertical direction.
  final GestureDragUpdateCallback? onVerticalDragUpdate;

  /// A pointer that was previously in contact with the screen and moving
  /// vertically is no longer in contact with the screen and was moving at a
  /// specific velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onVerticalDragEnd;

  /// The pointer that previously triggered [onVerticalDragDown] did not
  /// complete.
  final GestureDragCancelCallback? onVerticalDragCancel;

  /// A pointer has contacted the screen and might begin to move horizontally.
  final GestureDragDownCallback? onHorizontalDragDown;

  /// A pointer has contacted the screen and has begun to move horizontally.
  final GestureDragStartCallback? onHorizontalDragStart;

  /// A pointer that is in contact with the screen and moving horizontally has
  /// moved in the horizontal direction.
  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  /// A pointer that was previously in contact with the screen and moving
  /// horizontally is no longer in contact with the screen and was moving at a
  /// specific velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onHorizontalDragEnd;

  /// The pointer that previously triggered [onHorizontalDragDown] did not
  /// complete.
  final GestureDragCancelCallback? onHorizontalDragCancel;

  /// A pointer has contacted the screen and might begin to move.
  final GestureDragDownCallback? onPanDown;

  /// A pointer has contacted the screen and has begun to move.
  final GestureDragStartCallback? onPanStart;

  /// A pointer that is in contact with the screen and moving has moved again.
  final GestureDragUpdateCallback? onPanUpdate;

  /// A pointer that was previously in contact with the screen and moving
  /// is no longer in contact with the screen and was moving at a specific
  /// velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onPanEnd;

  /// The pointer that previously triggered [onPanDown] did not complete.
  final GestureDragCancelCallback? onPanCancel;

  /// The pointers in contact with the screen have established a focal point and
  /// initial scale of 1.0.
  final GestureScaleStartCallback? onScaleStart;

  /// The pointers in contact with the screen have indicated a new focal point
  /// and/or scale.
  final GestureScaleUpdateCallback? onScaleUpdate;

  /// The pointers are no longer in contact with the screen.
  final GestureScaleEndCallback? onScaleEnd;

  /// The pointer is in contact with the screen and has pressed with sufficient
  /// force to initiate a force press. The amount of force is at least
  /// [ForcePressGestureRecognizer.startPressure].
  ///
  /// Note that this callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressStartCallback? onForcePressStart;

  /// The pointer is in contact with the screen and has pressed with the maximum
  /// force. The amount of force is at least
  /// [ForcePressGestureRecognizer.peakPressure].
  ///
  /// Note that this callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressPeakCallback? onForcePressPeak;

  /// A pointer is in contact with the screen, has previously passed the
  /// [ForcePressGestureRecognizer.startPressure] and is either moving on the
  /// plane of the screen, pressing the screen with varying forces or both
  /// simultaneously.
  ///
  /// Note that this callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressUpdateCallback? onForcePressUpdate;

  /// The pointer is no longer in contact with the screen.
  ///
  /// Note that this callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressEndCallback? onForcePressEnd;

  /// How this gesture detector should behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.deferToChild] if [child] is not null and
  /// [HitTestBehavior.translucent] if child is null.
  final HitTestBehavior? behavior;

  /// Whether to exclude these gestures from the semantics tree. For
  /// example, the long-press gesture for showing a tooltip is
  /// excluded because the tooltip itself is included in the semantics
  /// tree directly and so having a gesture to show it would result in
  /// duplication of information.
  final bool excludeFromSemantics;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], gesture drag behavior will
  /// begin upon the detection of a drag gesture. If set to
  /// [DragStartBehavior.down] it will begin when a down event is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// Only the [onStart] callbacks for the [VerticalDragGestureRecognizer],
  /// [HorizontalDragGestureRecognizer] and [PanGestureRecognizer] are affected
  /// by this setting.
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  /// opacity when disabled. Default value is 0.5
  final double opacityDisable;

  /// Don't/Do set opacity when disabled. Default value is true
  final bool isOpacityWhenDisabled;

  GestureDetectorConfigs({
    required this.child,
    this.secondaryChild,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressDown,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.behavior = HitTestBehavior.opaque,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.disabled = false,
    this.opacityDisable = 0.5,
    this.isOpacityWhenDisabled = true,
    // ignore: unnecessary_null_comparison
  })  : assert(excludeFromSemantics != null),
        // ignore: unnecessary_null_comparison
        assert(dragStartBehavior != null),
        assert(
          () {
            final bool haveVerticalDrag = onVerticalDragStart != null ||
                onVerticalDragUpdate != null ||
                onVerticalDragEnd != null;
            final bool haveHorizontalDrag = onHorizontalDragStart != null ||
                onHorizontalDragUpdate != null ||
                onHorizontalDragEnd != null;
            final bool havePan =
                onPanStart != null || onPanUpdate != null || onPanEnd != null;
            final bool haveScale = onScaleStart != null ||
                onScaleUpdate != null ||
                onScaleEnd != null;
            if (havePan || haveScale) {
              if (havePan && haveScale) {
                throw FlutterError(
                  'Incorrect GestureDetectorThrottle arguments.\n'
                  'Having both a pan gesture recognizer and a scale gesture recognizer is redundant; scale is a superset of pan. Just use the scale gesture recognizer.',
                );
              }
              final String recognizer = havePan ? 'pan' : 'scale';
              if (haveVerticalDrag && haveHorizontalDrag) {
                throw FlutterError(
                  'Incorrect GestureDetectorThrottle arguments.\n'
                  'Simultaneously having a vertical drag gesture recognizer, a horizontal drag gesture recognizer, and a $recognizer gesture recognizer '
                  'will result in the $recognizer gesture recognizer being ignored, since the other two will catch all drags.',
                );
              }
            }

            return true;
          }(),
        );

  GestureDetectorConfigs copyWith({
    Widget? child,
    Widget? secondaryChild,
    GestureTapDownCallback? onTapDown,
    bool? disabled,
    GestureTapUpCallback? onTapUp,
    GestureTapCallback? onTap,
    GestureTapCancelCallback? onTapCancel,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureLongPressDownCallback? onLongPressDown,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,
    GestureDragDownCallback? onVerticalDragDown,
    GestureDragStartCallback? onVerticalDragStart,
    GestureDragUpdateCallback? onVerticalDragUpdate,
    GestureDragEndCallback? onVerticalDragEnd,
    GestureDragCancelCallback? onVerticalDragCancel,
    GestureDragDownCallback? onHorizontalDragDown,
    GestureDragStartCallback? onHorizontalDragStart,
    GestureDragUpdateCallback? onHorizontalDragUpdate,
    GestureDragEndCallback? onHorizontalDragEnd,
    GestureDragCancelCallback? onHorizontalDragCancel,
    GestureDragDownCallback? onPanDown,
    GestureDragStartCallback? onPanStart,
    GestureDragUpdateCallback? onPanUpdate,
    GestureDragEndCallback? onPanEnd,
    GestureDragCancelCallback? onPanCancel,
    GestureScaleStartCallback? onScaleStart,
    GestureScaleUpdateCallback? onScaleUpdate,
    GestureScaleEndCallback? onScaleEnd,
    GestureForcePressStartCallback? onForcePressStart,
    GestureForcePressPeakCallback? onForcePressPeak,
    GestureForcePressUpdateCallback? onForcePressUpdate,
    GestureForcePressEndCallback? onForcePressEnd,
    HitTestBehavior? behavior,
    bool? excludeFromSemantics,
    DragStartBehavior? dragStartBehavior,
    double? opacityDisable,
    bool? isOpacityWhenDisabled,
  }) {
    return GestureDetectorConfigs(
      child: child ?? this.child,
      secondaryChild: secondaryChild ?? this.secondaryChild,
      onTapDown: onTapDown ?? this.onTapDown,
      disabled: disabled ?? this.disabled,
      onTapUp: onTapUp ?? this.onTapUp,
      onTap: onTap ?? this.onTap,
      onTapCancel: onTapCancel ?? this.onTapCancel,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onLongPress: onLongPress ?? this.onLongPress,
      onLongPressDown: onLongPressDown ?? this.onLongPressDown,
      onLongPressStart: onLongPressStart ?? this.onLongPressStart,
      onLongPressMoveUpdate:
          onLongPressMoveUpdate ?? this.onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp ?? this.onLongPressUp,
      onLongPressEnd: onLongPressEnd ?? this.onLongPressEnd,
      onVerticalDragDown: onVerticalDragDown ?? this.onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart ?? this.onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate ?? this.onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd ?? this.onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel ?? this.onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown ?? this.onHorizontalDragDown,
      onHorizontalDragStart:
          onHorizontalDragStart ?? this.onHorizontalDragStart,
      onHorizontalDragUpdate:
          onHorizontalDragUpdate ?? this.onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd ?? this.onHorizontalDragEnd,
      onHorizontalDragCancel:
          onHorizontalDragCancel ?? this.onHorizontalDragCancel,
      onPanDown: onPanDown ?? this.onPanDown,
      onPanStart: onPanStart ?? this.onPanStart,
      onPanUpdate: onPanUpdate ?? this.onPanUpdate,
      onPanEnd: onPanEnd ?? this.onPanEnd,
      onPanCancel: onPanCancel ?? this.onPanCancel,
      onScaleStart: onScaleStart ?? this.onScaleStart,
      onScaleUpdate: onScaleUpdate ?? this.onScaleUpdate,
      onScaleEnd: onScaleEnd ?? this.onScaleEnd,
      onForcePressStart: onForcePressStart ?? this.onForcePressStart,
      onForcePressPeak: onForcePressPeak ?? this.onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate ?? this.onForcePressUpdate,
      onForcePressEnd: onForcePressEnd ?? this.onForcePressEnd,
      behavior: behavior ?? this.behavior,
      excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
      dragStartBehavior: dragStartBehavior ?? this.dragStartBehavior,
      opacityDisable: opacityDisable ?? this.opacityDisable,
      isOpacityWhenDisabled:
          isOpacityWhenDisabled ?? this.isOpacityWhenDisabled,
    );
  }
}
