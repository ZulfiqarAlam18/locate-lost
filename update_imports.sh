#!/bin/bash

# Script to update import statements after directory reorganization

echo "Updating import statements..."

# Update imports in all Dart files
find /home/zulfiqar/Desktop/fyp/locate-lost/lib -name "*.dart" -type f -exec sed -i \
  -e "s|import '../utils/app_colors.dart'|import '../core/constants/app_colors.dart'|g" \
  -e "s|import '../../utils/app_colors.dart'|import '../../core/constants/app_colors.dart'|g" \
  -e "s|import '../../../utils/app_colors.dart'|import '../../../core/constants/app_colors.dart'|g" \
  -e "s|import '../../../../utils/app_colors.dart'|import '../../../../core/constants/app_colors.dart'|g" \
  -e "s|import '../utils/app_constants.dart'|import '../core/constants/app_constants.dart'|g" \
  -e "s|import '../../utils/app_constants.dart'|import '../../core/constants/app_constants.dart'|g" \
  -e "s|import '../../../utils/app_constants.dart'|import '../../../core/constants/app_constants.dart'|g" \
  -e "s|import '../utils/dialog_utils.dart'|import '../core/utils/dialog_utils.dart'|g" \
  -e "s|import '../../utils/dialog_utils.dart'|import '../../core/utils/dialog_utils.dart'|g" \
  -e "s|import '../../../utils/dialog_utils.dart'|import '../../../core/utils/dialog_utils.dart'|g" \
  -e "s|import '../routes/app_routes.dart'|import '../navigation/app_routes.dart'|g" \
  -e "s|import '../../routes/app_routes.dart'|import '../../navigation/app_routes.dart'|g" \
  -e "s|import '../../../routes/app_routes.dart'|import '../../../navigation/app_routes.dart'|g" \
  -e "s|import '../routes/app_pages.dart'|import '../navigation/app_pages.dart'|g" \
  -e "s|import '../../routes/app_pages.dart'|import '../../navigation/app_pages.dart'|g" \
  -e "s|import '../services/location_permission_service.dart'|import '../data/services/location_permission_service.dart'|g" \
  -e "s|import '../../services/location_permission_service.dart'|import '../../data/services/location_permission_service.dart'|g" \
  -e "s|import '../../../services/location_permission_service.dart'|import '../../../data/services/location_permission_service.dart'|g" \
  -e "s|import '../widgets/|import '../presentation/widgets/|g" \
  -e "s|import '../../widgets/|import '../../presentation/widgets/|g" \
  -e "s|import '../../../widgets/|import '../../../presentation/widgets/|g" \
  -e "s|import '../../../../widgets/|import '../../../../presentation/widgets/|g" \
  -e "s|import '../views/|import '../presentation/pages/|g" \
  -e "s|import '../../views/|import '../../presentation/pages/|g" \
  -e "s|import '../../../views/|import '../../../presentation/pages/|g" \
  -e "s|import '../../../../views/|import '../../../../presentation/pages/|g" \
  {} \;

echo "Import statements updated successfully!"
