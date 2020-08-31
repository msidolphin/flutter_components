/// Syncfusion Flutter Charts is a data visualization library written natively in Dart for
/// creating beautiful and high-performance cartesian, circular, pyramid and funnel charts.
///
/// To use, import `package:syncfusion_flutter_charts/charts.dart`.
///
/// See also:
/// * [Syncfusion Flutter Charts product page](https://www.syncfusion.com/flutter-widgets/flutter-charts)
/// * [User guide documentation](https://help.syncfusion.com/flutter/chart/overview)
/// * [Video tutorials](https://www.syncfusion.com/tutorial-videos/flutter/charts)
/// * [Knowledge base](https://www.syncfusion.com/kb/flutter)

library charts;

import 'dart:async';
import 'dart:math' as math_lib;
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as dart_ui;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/intl.dart' show NumberFormat;
import 'package:vector_math/vector_math.dart' as vector;
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import './common/handcursor/mobile.dart'
if (dart.library.html) './common/handcursor/web.dart';

// export circular library
part './circular_chart/base/circular_base.dart';
part './circular_chart/base/series_base.dart';
part './circular_chart/renderer/circular-series.dart';
part './circular_chart/renderer/common.dart';
part './circular_chart/renderer/data_label_renderer.dart';
part './circular_chart/renderer/doughnut_series.dart';
part './circular_chart/renderer/pie_series.dart';
part './circular_chart/renderer/radial_bar_series.dart';
part './circular_chart/utils/enum.dart';
part './circular_chart/utils/helper.dart';

// export pyramid library
part './pyramid_chart/base/pyramid_base.dart';
part './pyramid_chart/base/series_base.dart';
part './pyramid_chart/renderer/pyramid_series.dart';
part './pyramid_chart/utils/common.dart';
part './pyramid_chart/utils/helper.dart';
part './pyramid_chart/renderer/data_label_renderer.dart';

// export funnel library
part './funnel_chart/base/funnel_base.dart';
part './funnel_chart/base/series_base.dart';
part './funnel_chart/renderer/funnel_series.dart';
part './funnel_chart/renderer/data_label_renderer.dart';

// export chart library
part './chart/annotation/annotation_settings.dart';
part './chart/axis/axis.dart';
part './chart/axis/axis_panel.dart';
part './chart/axis/axis_renderer.dart';
part './chart/axis/category_axis.dart';
part './chart/axis/datetime_axis.dart';
part './chart/axis/logarithmic_axis.dart';
part './chart/axis/numeric_axis.dart';
part './chart/axis/plotband.dart';
part './chart/base/chart_base.dart';
part './chart/base/series_base.dart';
part './chart/chart_behavior/chart_behavior.dart';
part './chart/chart_behavior/selection_behavior.dart';
part './chart/chart_behavior/zoom_behavior.dart';
part './chart/chart_segment/area_segment.dart';
part './chart/chart_segment/stacked_area_segment.dart';
part './chart/chart_segment/stackedarea100_segment.dart';
part './chart/chart_segment/bar_segment.dart';
part './chart/chart_segment/bubble_segment.dart';
part './chart/chart_segment/chart_segment.dart';
part './chart/chart_segment/column_segment.dart';
part './chart/chart_segment/fastline_segment.dart';
part './chart/chart_series/financial_series_base.dart';
part './chart/chart_segment/hilo_segment.dart';
part './chart/chart_segment/hiloopenclose_segment.dart';
part './chart/chart_segment/candle_segment.dart';
part './chart/chart_segment/line_segment.dart';
part './chart/chart_segment/histogram_segment.dart';
part './chart/chart_segment/stacked_line_segment.dart';
part './chart/chart_segment/range_area_segment.dart';
part './chart/chart_segment/stackedline100_segment.dart';
part './chart/chart_segment/range_column_segment.dart';
part './chart/chart_segment/scatter_segment.dart';
part './chart/chart_segment/spline_segment.dart';
part './chart/chart_segment/spline_area_segment.dart';
part './chart/chart_segment/spline_range_area_segment.dart';
part './chart/chart_series/stacked_series_base.dart';
part './chart/chart_segment/stacked_bar_segment.dart';
part './chart/chart_segment/stackedbar100_segment.dart';
part './chart/chart_segment/stacked_column_segment.dart';
part './chart/chart_segment/stackedcolumn100_segment.dart';
part './chart/chart_segment/step_area_segment.dart';
part './chart/chart_segment/stepline_segment.dart';
part './chart/chart_series/area_series.dart';
part './chart/chart_series/stacked_area_series.dart';
part './chart/chart_series/stackedarea100_series.dart';
part './chart/chart_series/bar_series.dart';
part './chart/chart_series/bubble_series.dart';
part './chart/chart_series/column_series.dart';
part './chart/chart_series/fastline_series.dart';
part './chart/chart_series/hilo_series.dart';
part './chart/chart_series/hiloopenclose_series.dart';
part './chart/chart_series/candle_series.dart';
part './chart/chart_series/line_series.dart';
part './chart/chart_series/histogram_series.dart';
part './chart/chart_series/stacked_line_series.dart';
part './chart/chart_series/range_area_series.dart';
part './chart/chart_series/stackedline100_series.dart';
part './chart/chart_series/range_column_series.dart';
part './chart/chart_series/scatter_series.dart';
part './chart/chart_series/stacked_bar_series.dart';
part './chart/chart_series/stackedbar100_series.dart';
part './chart/chart_series/stacked_column_series.dart';
part './chart/chart_series/stackedcolumn100_series.dart';
part './chart/chart_series/series.dart';
part './chart/chart_series/spline_series.dart';
part './chart/chart_series/spline_area_series.dart';
part './chart/chart_series/spline_range_area_series.dart';
part './chart/chart_series/step_area_series.dart';
part './chart/chart_series/stepline_series.dart';
part './chart/chart_series/xy_data_series.dart';
part './chart/common/common.dart';
part './chart/common/data_label.dart';
part './chart/common/data_label_renderer.dart';
part './chart/common/marker.dart';
part './chart/common/renderer.dart';
part './chart/series_painter/area_painter.dart';
part './chart/series_painter/stacked_area_painter.dart';
part './chart/series_painter/stackedarea100_painter.dart';
part './chart/series_painter/bar_painter.dart';
part './chart/series_painter/bubble_painter.dart';
part './chart/series_painter/column_painter.dart';
part './chart/series_painter/fastline_painter.dart';
part './chart/series_painter/hilo_painter.dart';
part './chart/series_painter/hiloopenclose_painter.dart';
part './chart/series_painter/candle_painter.dart';
part './chart/series_painter/line_painter.dart';
part './chart/series_painter/histogram_painter.dart';
part './chart/series_painter/stacked_line_painter.dart';
part './chart/series_painter/range_area_painter.dart';
part './chart/series_painter/stackedline100_painter.dart';
part './chart/series_painter/range_column_painter.dart';
part './chart/series_painter/scatter_painter.dart';
part './chart/series_painter/spline_painter.dart';
part './chart/series_painter/spline_area_painter.dart';
part './chart/series_painter/spline_range_area_painter.dart';
part './chart/series_painter/stacked_bar_painter.dart';
part './chart/series_painter/stackedbar100_painter.dart';
part './chart/series_painter/stacked_column_painter.dart';
part './chart/series_painter/stackedcolumn100_painter.dart';
part './chart/series_painter/step_area_painter.dart';
part './chart/series_painter/stepline_painter.dart';
part './chart/technical_indicators/accumulation_distribution_indicator.dart';
part './chart/technical_indicators/atr_indicator.dart';
part './chart/technical_indicators/bollinger_bands_indicator.dart';
part './chart/technical_indicators/ema_indicator.dart';
part './chart/technical_indicators/tma_indicator.dart';
part './chart/technical_indicators/rsi_indicator.dart';
part './chart/technical_indicators/sma_indicator.dart';
part './chart/technical_indicators/macd_indicator.dart';
part './chart/technical_indicators/momentum_indicator.dart';
part './chart/technical_indicators/stochastic_indicator.dart';
part './chart/technical_indicators/technical_indicator.dart';
part './chart/trendlines/trendlines.dart';
part './chart/trendlines/trendlines_painter.dart';
part './chart/user_interaction/crosshair.dart';
part './chart/user_interaction/crosshair_painter.dart';
part './chart/user_interaction/selection_renderer.dart';
part './chart/user_interaction/tooltip_painter.dart';
part './chart/user_interaction/tooltip_template.dart';
part './chart/user_interaction/trackball.dart';
part './chart/user_interaction/trackball_painter.dart';
part './chart/user_interaction/zooming_painter.dart';
part './chart/user_interaction/zooming_panning.dart';
part './chart/utils/enum.dart';
part './chart/utils/helper.dart';

// export common library
part './common/common.dart';
part './common/event_args.dart';
part './common/legend/legend.dart';
part './common/legend/renderer.dart';
part './common/series/chart_series.dart';
part './common/template/rendering.dart';
part './common/user_interaction/selection.dart';
part './common/user_interaction/tooltip.dart';
part './common/utils/enum.dart';
part './common/utils/helper.dart';
