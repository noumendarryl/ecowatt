// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class CustomCard extends StatelessWidget {
//   final int id;
//   final Color? color;
//   final String title;
//   final List<String> categories;
//   final Widget? child;
//
//   const CustomCard(
//       {super.key,
//       required this.id,
//       required this.title,
//       required this.categories,
//       this.color,
//       this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     /// Access the CategoryCubit
//     final categoryCubit = context.read<CategoryCubit>();
//
//     /// Set the initial group value to the first item of the categories list
//     categoryCubit.setCategory(id, categories.first);
//
//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               padding: const EdgeInsets.all(Sizes.spacing),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surface,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Reset',
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.scrim,
//                           fontFamily:
//                               Theme.of(context).textTheme.bodyLarge!.fontFamily,
//                           fontSize:
//                               Theme.of(context).textTheme.bodyLarge!.fontSize,
//                         ),
//                       ),
//                       Text(
//                         title,
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.scrim,
//                           fontFamily: Theme.of(context)
//                               .textTheme
//                               .titleSmall!
//                               .fontFamily,
//                           fontSize:
//                               Theme.of(context).textTheme.titleSmall!.fontSize,
//                           fontWeight: Theme.of(context)
//                               .textTheme
//                               .titleSmall!
//                               .fontWeight,
//                         ),
//                       ),
//                       Container(
//                         width: 40.0,
//                         height: 40.0,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.tertiary,
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.close,
//                             color: Theme.of(context).colorScheme.scrim,
//                             size: Sizes.iconSizeMedium,
//                           ),
//                           onPressed: () {
//                             context.router.pop();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: Sizes.space),
//                   Container(
//                     height: 300.0,
//                     padding: const EdgeInsets.all(Sizes.space),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.primary,
//                       borderRadius: BorderRadius.circular(Sizes.spacing),
//                     ),
//                     child: ListView.separated(
//                         itemBuilder: (context, index) {
//                           return BlocBuilder<CategoryCubit, CategoryState>(
//                               builder: (context, state) {
//                             return RadioButton(
//                                 label: categories[index],
//                                 value: categories[index],
//                                 groupValue: categoryCubit.getCategory(id),
//                                 onChanged: (String? val) {
//                                   if (val != null) {
//                                     categoryCubit.setCategory(id, val);
//                                   }
//                                 });
//                           });
//                         },
//                         separatorBuilder: (context, index) => Divider(
//                             thickness: 1.0,
//                             color: Theme.of(context).colorScheme.tertiary),
//                         itemCount: categories.length),
//                   ),
//                   const SizedBox(height: Sizes.space),
//                   Button(label: 'Confirm', onPressed: () {
//                     context.pushRoute(EquipmentListRoute(industry: title, category: categoryCubit.getCategory(id)));
//                   })
//                 ],
//               ),
//             );
//           },
//         );
//       },
//       child: Container(
//           width: 180.0,
//           height: 170.0,
//           decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(Sizes.doubleRadius)),
//           child: child),
//     );
//   }
// }
