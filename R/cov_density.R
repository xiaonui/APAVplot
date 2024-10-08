

#' cov_density
#'
#' @param cov_obj A COV object.
#' @param regions A vector of regions.
#' @param add_region_info A character vector of `region_info` names.
#' @param density_color A string of color for density chart.
#' @param scale A number indicating relative height of density distribution.
#'
#' @param region_info_side The position of `region_info` annotation ("left" and "right").
#' @param region_info_color_list A list contains colors for `region_info` annotation.
#'  e.g. list(source = c("reference" = "red", "novel" = "blue"), length = c("orange", "red"))
#' @param anno_param_row_region A list contains parameters for the region annotation. These can be any of the following:
#' "show", "width", "border", "name_size", "name_rot" and "name_side".
#'
#' @param show_row_names A logical value indicating whether show row names.
#' @param row_names_side The position of row names ("left", "right").
#' @param row_names_size The size of row names.
#' @param row_names_rot The rotation of row names.
#'
#' @param legend_side The position of legend ("top", "bottom", "right", "left").
#' @param legend_title_size The size of legend title.
#' @param legend_text_size The size of legend item labels.
#' @param legend_grid_size A \code{\link[grid]{unit}} object for the size of legend grid.
#'
#'
#' @export

cov_density <- function(cov_obj,
                        regions,
                        add_region_info = NULL,
                        density_color = "#7e9bc0",
                        scale = 2,

                        show_row_names = T,
                        row_names_side = "left",
                        row_names_size = 10,
                        row_names_rot = 0,

                        region_info_color_list = NULL,
                        region_info_side = "right",
                        anno_param_row_region = list(show = T, width = 5, border = FALSE,
                                                   name_size = NULL, name_rot = 90, name_side = "bottom"),

                        legend_side = "right",
                        legend_title_size = NULL,
                        legend_text_size = NULL,
                        legend_grid_size = grid::unit(4, "mm")){

  check_class(cov_obj, "COV")

  cov_data <- cov_obj@cov_data[regions, ]

  if(length(cov_obj@region) > 0 && length(add_region_info) > 0){
    data_info <- as.list(as.data.frame(cov_obj@region)[rownames(cov_obj@cov_data) %in% regions, ])
    add_region_info <- match.arg(add_region_info, names(data_info), several.ok = T)
    data_info <- data_info[add_region_info]

    color_info <- get_anno_palette(region_info_color_list, data_info)

    anno_param_row_region_def_args <- list(show = T, width = 5, border = FALSE,
                                         name_size = NULL, name_rot = 0, name_side = "bottom")
    anno_param_row_region <- merge_args(anno_param_row_region_def_args, anno_param_row_region)

    if(anno_param_row_region$show){
      anno_region <- get_anno_row(data_info, color_info, anno_param_row_region)
    } else {
      anno_region <- NULL
    }
  } else {
    anno_region <- NULL
    color_info <- NULL
  }

  if(region_info_side == "right"){
    anno_right <- anno_region
    anno_left <- NULL
  } else if(region_info_side == "left") {
    anno_right <- NULL
    anno_left <- anno_region
  }

  lg_info <- get_legend(color_info, data_info, legend_title_size, legend_text_size, legend_grid_size)

  p_data <- cov_data
  ht <- ComplexHeatmap::Heatmap(matrix(NA, nrow = nrow(p_data), ncol = 0, dimnames = list(rownames(p_data))),
                                cluster_columns = F,
                                cluster_rows = F,
                                show_row_names = ifelse(show_row_names & row_names_side == "left", T, F),
                                row_names_rot = row_names_rot,
                                row_names_side = row_names_side,
                                row_names_gp = grid::gpar(fontsize = row_names_size, fontface = "bold"),
                                left_annotation = anno_left,
                                right_annotation = ComplexHeatmap::rowAnnotation(
                                  Coverage = ComplexHeatmap::anno_density(
                                    data.frame(t(p_data)), border = F, joyplot_scale = scale,
                                    gp = grid::gpar(fill = density_color, alpha = .5),
                                    axis_param = list(gp = grid::gpar(fontsize = row_names_size, fontface = "bold"))),
                                  annotation_name_gp=grid::gpar(fontface = "bold")
                                ))

  ht_right <- ComplexHeatmap::Heatmap(matrix(NA, nrow = nrow(p_data), ncol = 0, dimnames = list(rownames(p_data))),
                                      show_heatmap_legend = F,
                                      rect_gp =  grid::gpar(type = "none"),
                                      show_row_names = ifelse(show_row_names & row_names_side == "right", T, F),
                                      row_names_rot = row_names_rot,
                                      row_names_side = row_names_side,
                                      row_names_gp = grid::gpar(fontsize = row_names_size, fontface = "bold"),
                                      show_column_names = F,
                                      right_annotation = anno_right
  )

  ComplexHeatmap::draw(ht + ht_right,
                       auto_adjust = FALSE,
                       heatmap_legend_list = lg_info,
                       merge_legend = T,
                       heatmap_legend_side = legend_side)
}



