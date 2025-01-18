"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.NutritionistController = void 0;
const common_1 = require("@nestjs/common");
const nutritionist_service_1 = require("./nutritionist.service");
const role_guard_1 = require("../../auth/guards/role.guard");
const user_enums_1 = require("../../enums/user-enums");
let NutritionistController = class NutritionistController {
    constructor(nutritionistService) {
        this.nutritionistService = nutritionistService;
    }
    async findAll() {
        return this.nutritionistService.findAll();
    }
};
exports.NutritionistController = NutritionistController;
__decorate([
    (0, role_guard_1.Roles)(user_enums_1.UserRoleEnum.ADMIN, user_enums_1.UserRoleEnum.CLIENT),
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], NutritionistController.prototype, "findAll", null);
exports.NutritionistController = NutritionistController = __decorate([
    (0, common_1.Controller)('nutritionists'),
    __metadata("design:paramtypes", [nutritionist_service_1.NutritionistService])
], NutritionistController);
//# sourceMappingURL=nutritionist.controller.js.map