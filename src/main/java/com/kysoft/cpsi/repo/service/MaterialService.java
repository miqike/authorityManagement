package com.kysoft.cpsi.repo.service;

import java.util.List;

import com.kysoft.cpsi.repo.entity.Material;

public interface MaterialService {

	List<Material> getCandidateMaterial(String hcsxId);

	List<Material> getAllMaterial();

}
