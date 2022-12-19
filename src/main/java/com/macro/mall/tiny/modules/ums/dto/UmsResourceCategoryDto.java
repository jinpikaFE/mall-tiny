package com.macro.mall.tiny.modules.ums.dto;

import com.macro.mall.tiny.modules.ums.model.UmsResource;
import com.macro.mall.tiny.modules.ums.model.UmsResourceCategory;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class UmsResourceCategoryDto extends UmsResourceCategory {
    @ApiModelProperty(value = "分类下的资源")
    private List<UmsResource> resources;
}
