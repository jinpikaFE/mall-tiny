package com.macro.mall.tiny.modules.ums.dto;

import com.macro.mall.tiny.modules.ums.model.UmsRole;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class UmsRoleParams extends UmsRole {
    @ApiModelProperty(value = "菜单ids")
    private List<Long> menus;
    @ApiModelProperty(value = "资源ids")
    private List<Long> resources;
}
