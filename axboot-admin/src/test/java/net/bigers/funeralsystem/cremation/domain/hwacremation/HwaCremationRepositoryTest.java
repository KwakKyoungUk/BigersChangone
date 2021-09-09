package net.bigers.funeralsystem.cremation.domain.hwacremation;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import com.axisj.axboot.admin.AdminApplicationInitializer;

import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationRepository;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={AdminApplicationInitializer.class})
@WebAppConfiguration
public class HwaCremationRepositoryTest {

	@Autowired
	private HwaCremationRepository repository;

//	private MockMvc mockMvc;

	@Autowired
	private WebApplicationContext wac;

	@Before
	public void setUp(){
		MockitoAnnotations.initMocks(this);
//		mockMvc = MockMvcBuilders.standaloneSetup(bord1010Controller).build();
	}

	@Test
	public void pk_pluse_일반컬럼_조인_테스트() throws Exception{
		System.out.println(repository);

//		repository = wac.getBean(HwaCremationRepository.class);
		System.out.println(repository);

		//HwaCremation res = repository.findOne(HwaCremationId.of("20160603", "1"));

		//System.out.println(res);
	}
}
