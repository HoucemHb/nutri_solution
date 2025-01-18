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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.NutritionistService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const user_service_1 = require("../user.service");
const nutritionist_entity_1 = require("./nutritionist.entity");
let NutritionistService = class NutritionistService extends user_service_1.UserService {
    constructor(nutritionistRepository) {
        super(nutritionistRepository);
        this.nutritionistRepository = nutritionistRepository;
    }
    async findAll() {
        return this.nutritionistRepository.find();
    }
    async findOne(id) {
        const user = await this.nutritionistRepository.findOneBy({ id });
        if (!user) {
            throw new common_1.NotFoundException(`User with ID ${id} not found`);
        }
        return user;
    }
    async update(id, updateNutritionistDto) {
        const user = await this.findOne(id);
        Object.assign(user, updateNutritionistDto);
        return this.userRepository.save(user);
    }
};
exports.NutritionistService = NutritionistService;
exports.NutritionistService = NutritionistService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(nutritionist_entity_1.Nutritionist)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], NutritionistService);
//# sourceMappingURL=nutritionist.service.js.map