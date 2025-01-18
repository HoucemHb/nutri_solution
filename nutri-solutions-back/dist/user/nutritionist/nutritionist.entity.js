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
exports.Nutritionist = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("../user.entity");
const user_enums_1 = require("../../enums/user-enums");
let Nutritionist = class Nutritionist extends user_entity_1.UserEntity {
};
exports.Nutritionist = Nutritionist;
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Nutritionist.prototype, "experienceYears", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Nutritionist.prototype, "certificateUrl", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Nutritionist.prototype, "location", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], Nutritionist.prototype, "patientsNumber", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: user_enums_1.NutritionistStatusEnum,
        default: user_enums_1.NutritionistStatusEnum.WAITING,
    }),
    __metadata("design:type", String)
], Nutritionist.prototype, "status", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 4 }),
    __metadata("design:type", Number)
], Nutritionist.prototype, "stars", void 0);
exports.Nutritionist = Nutritionist = __decorate([
    (0, typeorm_1.ChildEntity)()
], Nutritionist);
//# sourceMappingURL=nutritionist.entity.js.map